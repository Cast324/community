"""
Applet: Minecraft Server
Summary: Minecraft Server Activity
Description: View Minecraft Server Activity and icon.
Author: Michael Blades
"""

load("render.star", "render")
load("http.star", "http")
load("encoding/base64.star", "base64")
load("encoding/json.star", "json")
load("schema.star", "schema")
load("cache.star", "cache")

def main(config):
    result_cached = cache.get("api_result")
    if result_cached != None:
        resultData = base64.decode(result_cached)
        result = json.decode(resultData)
    else:
        minecraftURL = config.get("server", "mc.azitoth.com")
        apiURL = "".join(["https://api.mcsrvstat.us/2/", minecraftURL])
        result = http.get(apiURL)
        if result.status_code != 200:
            fail("Minecraft API request failed with status %d", result.status_code)
        cache.set("api_result", base64.encode(result.body()), ttl_seconds = 300)
    
    onlinePlayers = result.json()["players"]["online"]
    maxPlayers = result.json()["players"]["max"]
    motd = result.json()["motd"]["clean"][0]
    motd2 = result.json()["motd"]["clean"][1]
    iconURL = result.json()["icon"].split(",")[1]
    serverIcon = base64.decode("""%s""" % iconURL)

    return render.Root(
        child = render.Column(
            children = [
                render.Row(
                    children = [
                        render.Image(src = serverIcon, width = 25, height = 25),
                        render.Column(
                            children = [
                                render.Marquee(
                                    width = 40,
                                    child = render.Text("%d Online" % onlinePlayers),
                                ),
                                render.Marquee(
                                    width = 40,
                                    child = render.Text("%d Max" % maxPlayers),
                                ),
                                render.Marquee(
                                    width = 64,
                                    child = render.Text("%s" % motd),
                                ),
                                render.Marquee(
                                    width = 64,
                                    child = render.Text("%s" % motd2),
                                ),
                            ],
                        ),
                    ],
                ),
            ],
        ),
    )

def get_schema():
    return schema.Schema(
        version = "1",
        fields = [
            schema.Text(
                id = "server",
                name = "Server URL",
                desc = "URL or IP of Minecraft Server",
                icon = "server",
            ),
        ],
    )
