using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace EchoApi.Controllers
{
    [ApiController]
    [Route("/")]
    public class EchoController : ControllerBase
    {
        [HttpGet("/")]
        public async Task<ActionResult<string>> Get([FromQuery]string text)
        {
            var input = text?.Trim();
            if (string.IsNullOrEmpty(input))
            {
                input = $"{DateTime.UtcNow}";
            }
            
            var output = await Task.FromResult(input);
            return Ok(output);
        }
    }
}
