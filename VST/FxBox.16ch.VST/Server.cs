using System;
using System.Collections.Concurrent;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace FxBox.VST
{
    internal class Server
    {
        const int MAXCHANNELS = 16;
        internal double MONHZ = 50;
        internal double CHANNELS = 1;
        internal double RATE;
        

        private int C;
        private int FX;
        private int FXE;
        private double CN;
        private int CN2;
        private int CN3;
        private double ADV;
        private double CON;
        private byte[] PBANK;
        private byte[] VAR = new byte[4];
        private double VA = 1;
        private int BYPS = 1;

        private UdpClient UdpServer;
        private UdpReceiveResult udpReceive;
        private bool udpListening;

        internal ConcurrentQueue<double>[] Samples = new ConcurrentQueue<double>[MAXCHANNELS];

        internal Server(int port, bool debug = false)
        {
            for (C = 0; C < MAXCHANNELS; C++) Samples[C] = new ConcurrentQueue<double>();
            VAR[3] = 0;

            try
            {
                UdpServer = new UdpClient(port);
                udpListening = true;
            }
            catch (Exception exc)
            {
                if (debug) Console.WriteLine(exc.Message);
            }

            Task.Run(async () =>
            {
                while (udpListening)
                {
                    try
                    {
                        udpReceive = await UdpServer.ReceiveAsync().ConfigureAwait(false);
                    }
                    catch (Exception exc)
                    {
                        //cannot access a disposed object
                        if (debug) Console.WriteLine(exc.Message);
                        break;
                    }

                    PBANK = udpReceive.Buffer;
                    if (PBANK.Length > 65280)
                    {
                        try
                        {
                            udpReceive = await UdpServer.ReceiveAsync().ConfigureAwait(false);
                        }
                        catch (Exception exc)
                        {
                            //cannot access a disposed object
                            if (debug) Console.WriteLine(exc.Message);
                            break;
                        }

                        byte[] PBANK2 = new byte[PBANK.Length + udpReceive.Buffer.Length];

                        PBANK.CopyTo(PBANK2, 0);
                        udpReceive.Buffer.CopyTo(PBANK2,PBANK.Length);

                        PBANK = PBANK2;
                    }

                    if (debug) Console.Write("buffer: " + PBANK.Length + " ");
                    if (PBANK.Length > 0)
                    {
                        if (PBANK.Length < 4)
                        {
                            CHANNELS = PBANK[0];

                            if (CHANNELS == 1 || CHANNELS == 2 || CHANNELS == 4 || CHANNELS == 8 || CHANNELS == 16)
                            {
                                if (PBANK.Length > 1)
                                {
                                    BYPS = PBANK[1];
                                    if (debug) { Console.Write("bytes per sample: " + BYPS + " "); }
                                }

                                if (PBANK.Length > 2)
                                {
                                    VA = (int)PBANK[2] / 64.0;
                                    if (debug) { Console.Write("volume: " + VA + " "); }
                                }
                            }
                            else
                            {
                                CHANNELS = Convert.ToInt32(Encoding.ASCII.GetString(PBANK));
                            }
                            if (debug) { Console.Write("channels: " + CHANNELS + " "); }
                        }
                        else
                        {
                            ADV = ((PBANK.Length) / CHANNELS) / BYPS;
                            CON = ((ADV * MONHZ) / RATE);
                            FXE = (int)(((ADV / CON)) * BYPS);
                            for (C = 0; C < CHANNELS; C++)
                            {
                                if (debug) Console.Write(C + " ");
                                for (FX = 0; FX < FXE; FX += BYPS)
                                {
                                    CN2 = ((int)(FX * CON)/BYPS) * BYPS;
                                    CN3 = CN2 + (int)(ADV * C) * BYPS;
                                    switch (BYPS)
                                    {
                                        case 1:
                                            CN = PBANK[CN3];
                                            if (CN > 127)
                                            {
                                                CN = (CN - 256) / 128.0;
                                            }
                                            else
                                            {
                                                CN = CN / 127.0;
                                            }
                                            break;
                                        case 2:
                                            VAR[0] = PBANK[CN3 + 1];
                                            VAR[1] = PBANK[CN3];
                                            CN = BitConverter.ToUInt16(VAR, 0);
                                            if (CN > 32767)
                                            {
                                                CN = (CN - 65536) / 32768.0;
                                            }
                                            else
                                            {
                                                CN = CN / 32767.0;
                                            }
                                            break;
                                        case 3:
                                            VAR[0] = PBANK[CN3 + 2];
                                            VAR[1] = PBANK[CN3 + 1];
                                            VAR[2] = PBANK[CN3];
                                            CN = BitConverter.ToUInt32(VAR, 0);
                                            if (CN > 8388607)
                                            {
                                                CN = (CN - 16777216) / 8388608.0;
                                            }
                                            else
                                            {
                                                CN = CN / 8388607.0;
                                            }
                                            break;
                                        default:
                                            break;
                                    }

                                    Samples[C].Enqueue(CN*VA);
                                }
                            }
                        }
                    }
                }

                Stop();

            }).ConfigureAwait(false);
        }

        public void Stop()
        {
            udpListening = false;
            if (UdpServer != null) UdpServer.Close();
        }
    }
}
