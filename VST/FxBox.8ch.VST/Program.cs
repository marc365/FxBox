using System;

namespace FxBox.VST
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("Press the any key!");
            Server server = new Server(7002, true);
            Console.ReadKey();
            server.Stop();
        }
    }
}
