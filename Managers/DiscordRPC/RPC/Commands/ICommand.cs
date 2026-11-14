using Spectr.Managers.DiscordRPC.RPC.Payload;

namespace Spectr.Managers.DiscordRPC.RPC.Commands
{
    internal interface ICommand
    {
        IPayload PreparePayload(long nonce);
    }
}
