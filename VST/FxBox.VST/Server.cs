using System;
using System.Collections.Concurrent;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace FxBox.VST
{
    internal class Server
    {
        internal double MONHZ = 50;
        internal double CHANNELS = 1;
        internal double RATE;

        private int C;
        private int FX;
        private int FXE;
        private double CN;
        private int CN2;
        private double ADV;
        private double CON;
        private byte[] PBANK;

        private UdpClient UdpServer;
        private UdpReceiveResult udpReceive;
        private bool udpListening;

        internal ConcurrentQueue<double>[] Samples = new ConcurrentQueue<double>[4];

        internal Server(int port, bool debug = false)
        {
            Task.Run(async () =>
            {
                for (C = 0; C < 4; C++) Samples[C] = new ConcurrentQueue<double>();

                try
                {
                    UdpServer = new UdpClient(port);
                    udpListening = true;
                }
                catch (Exception exc)
                {
                    if (debug) Console.WriteLine(exc.Message);
                }

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
                    if (debug) Console.Write("buffer: " + PBANK.Length + " ");
                    if (PBANK.Length == 1)
                    {
                        CHANNELS = Convert.ToInt32(Encoding.ASCII.GetString(PBANK));
                        if (debug) Console.Write("channels: " + CHANNELS + " ");
                    }
                    else
                    {
                        ADV = (PBANK.Length / CHANNELS);
                        CON = (ADV * MONHZ) / RATE;
                        FXE = (int)(ADV / CON);
                        for (C = 0; C < CHANNELS; C++)
                        {
                            if (debug) Console.Write(C + " ");
                            for (FX = 0; FX < FXE; FX++)
                            {
                                CN2 = (int)(FX * CON);
                                CN = PBANK[CN2 + (int)(ADV * C)];
                                if (CN > 127) CN = CN - 256;
                                CN = CN / 127.0;
                                Samples[C].Enqueue(CN);
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
            if (UdpServer == null) return;
            UdpServer.Close();
        }
    }
}
