using SharpSoundDevice;
using System;

namespace FxBox.VST
{
    public class Plugin : IAudioDevice
    {
        private DeviceInfo DevInfo;

        private double sample;
        private int i;
        private int c;

        private Server server;

        public int CurrentProgram { get; private set; }
        public DeviceInfo DeviceInfo { get { return DevInfo; } }
        public IHostInfo HostInfo { get; set; }
        public Parameter[] ParameterInfo { get; private set; }
        public Port[] PortInfo { get; private set; }


        public Plugin()
        {
            DevInfo = new DeviceInfo();
            DevInfo.Developer = "Marc Williams";
            DevInfo.DeviceID = "Marc Williams - FxBox.VST";
            DevInfo.EditorHeight = 0;
            DevInfo.EditorWidth = 0;
            DevInfo.HasEditor = false;
            DevInfo.Name = "FxBox.VST";
            DevInfo.ProgramCount = 1;
            DevInfo.Type = DeviceType.Generator;
            DevInfo.Version = 1000;
            DevInfo.VstId = DeviceUtilities.GenerateIntegerId(DevInfo.DeviceID);

            ParameterInfo = new Parameter[0];

            PortInfo = new Port[1]
            {
	            new Port() { Direction = PortDirection.Output, Name = "Paula Output", NumberOfChannels = 4 }
            };
        }

        public void InitializeDevice() { }

        public void DisposeDevice() { }

        public void Start()
        {
            server = new Server(7002);
            HostChanged();
        }

        public void Stop()
        {
            server.Stop();
        }

        public void OpenEditor(IntPtr parentWindow) { }

        public void CloseEditor() { }

        public void HostChanged()
        {
            server.RATE = HostInfo.SampleRate;
        }

        public void ProcessSample(double[][] input, double[][] output, uint bufferSize)
        {
            for (int i = 0; i < bufferSize; i++)
            {
                for (c = 0; c < server.CHANNELS; c++)
                {
                    if (server.Samples[c].TryDequeue(out sample))
                    {
                        output[c][i] = sample;
                    }
                }
            }
        }

        public void SendEvent(Event ev) { }

        public void SetParam(int index, double value) { }

        public Program GetProgramData(int index) { return default(Program); }

        public void SetProgramData(Program program, int index) { }

    }
}
