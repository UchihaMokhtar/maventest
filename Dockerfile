#first stage base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source

#copy csproj and restore dependecies
COPY *.csproj .
RUN dotnet restore

#copy and publish application files
COPY . . 
RUN dotnet publish -c release -o /app

#final stage
FROM mcr.microsoft.com/dotnet/aspnet:5.0 
WORKDIR /app
COPY --from=build /app .

ENTRYPOINT [ "dotnet", "hrapp.dll" ]
