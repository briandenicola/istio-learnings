using Grpc.Core;
using server;

namespace server.Services;

public class GreeterService : Greeter.GreeterBase
{
    private readonly ILogger<GreeterService> _logger;
    public GreeterService(ILogger<GreeterService> logger)
    {
        _logger = logger;
    }

    public override Task<HelloReply> SayHello(HelloRequest request, ServerCallContext context)
    {
        return Task.FromResult(new HelloReply
        {
            Message = $"[{DateTime.UtcNow}] - Hello {request.Name} from SayHello...."
        });
    }

    public override async Task SayHelloStream(HelloRequest request, IServerStreamWriter<HelloReply> responseStream, ServerCallContext context)
    {
        var waitTime = 20;
        var counter  = 0;

        do
        {
            await responseStream.WriteAsync(new HelloReply
            {
                Message = $"[{DateTime.UtcNow}] - Hello {request.Name} from SayHelloStream....(Sleeping now for 20 seconds)"
            });

            await Task.Delay(TimeSpan.FromSeconds(waitTime));
            counter++;
        } while ( counter < 100 );

    }

}
