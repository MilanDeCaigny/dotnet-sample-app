# Hoe de fabriek er een kant-en-klare doos (container) van maakt (Inpakinstructie).

# Downloaden van officiële Microsoft image waar .NET 8.0 SDK op staat.
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# Maakt map /src aan.
WORKDIR /src
# Kopieert alle bestanden van huidige map van op pc naar /src.
COPY . .
# Voert .NEcompilatiecommando uit. -c = Release-modus (geoptimaliseerd voor snelheid ens.).
RUN dotnet publish -c Release -o /app/publish

# Pakt de lichte .NET runtime.
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
# Gaat naar de map /app in de container.
WORKDIR /app
# Kopieert het afgewerkte product uit bouwfase naar /app.
COPY --from=build /app/publish .
# Zegt tegen .NET dat hij op poort 5000 moet luisteren.
ENV ASPNETCORE_URLS=http://+:5000
# Zet deze poort open binnen container.
EXPOSE 5000
# Start de applicatie op.
ENTRYPOINT ["dotnet", "dotnet-sample-app.dll"]