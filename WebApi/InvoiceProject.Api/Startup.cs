using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using InvoiceProject.Api.DbContext;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;

namespace InvoiceProject.Api
{
    public class Startup
    {
        public Startup(IConfiguration config)
        {
            _config = config;
            ConnectionString conStr = new ConnectionString
            {
                Server = config["SqlServer:Server"],
                IntegratedSecurity = config["SqlServer:IntegratedSecurity"],
                Database = config["SqlServer:Database"],
                UserId = config["SqlServer:UserId"],
                Password = config["SqlServer:Password"]
            };
            Connection.Initialize(conStr);
        }
        private readonly IConfiguration _config;
        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(options =>
                {
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        ValidIssuer = _config["Jwt:Issuer"],
                        ValidAudience = _config["Jwt:Audience"],
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]))
                    };
                });
            services.AddCors(options =>
            {
                options.AddPolicy("AllowOrigin", builder =>
                {
                    builder.WithOrigins("http://localhost:4200")
                    .AllowAnyHeader()
                    .AllowAnyMethod()
                    .AllowCredentials();
                });
            });
            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);
            services.AddApiVersioning();
            services.Configure<IISOptions>(options =>
            {
                options.AutomaticAuthentication = false;
            });
        }
        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler(errorApp =>
                {
                    errorApp.Run(async context =>
                    {
                        context.Response.StatusCode = 500;
                        context.Response.ContentType = "text/html";

                        // await context.Response.WriteAsync("<html lang=\"en\"><body>\r\n");
                        // await context.Response.WriteAsync("ERROR!<br><br>\r\n");

                        var exceptionHandlerPathFeature =
                            context.Features.Get<IExceptionHandlerPathFeature>();

                        if (exceptionHandlerPathFeature?.Error is FileNotFoundException)
                        {
                            await context.Response.WriteAsync(
                                                      "File error thrown!<br><br>\r\n");
                        }

                        //  await context.Response.WriteAsync("<a href=\"/\">Home</a><br>\r\n");
                        //await context.Response.WriteAsync("</body></html>\r\n");
                        await context.Response.WriteAsync("An error occured.");
                        await context.Response.WriteAsync(context.Features.Get<Exception>().Message);
                        await context.Response.WriteAsync(new string(' ', 512));
                    });
                });
                app.UseHsts();
            }
            app.UseCors("AllowOrigin");
            app.UseAuthentication();
            app.UseMvc();
        }
    }
}
