using System;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

using Grpc.Net.Client;
using Grpc.Core;
using Client;

var builder = new ConfigurationBuilder().AddCommandLine(args);
var config = builder.Build();

var address = config["GrpcEndpoint"];

Console.WriteLine($"Connecting to {address}");

var channel = GrpcChannel.ForAddress(address);
var client = new Greeter.GreeterClient(channel);

var replies = client.SayHelloStream(
    new HelloRequest(){ Name = "Brian" },
    deadline: DateTime.UtcNow.AddMinutes(10)
);

try 
{
    var reply = client.SayHello(
        new HelloRequest(){ Name = "Brian" }
    );
    Console.WriteLine($"Reply: {reply.Message}");
    
    await foreach (var streamreply in replies.ResponseStream.ReadAllAsync())
    {
        Console.WriteLine($"Reply: {streamreply.Message}");
    }
}
catch (RpcException ex) when (ex.StatusCode == StatusCode.DeadlineExceeded)
{
    Console.WriteLine("Stream timed out after 10 minutes.");
}
