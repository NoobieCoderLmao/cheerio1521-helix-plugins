local PLUGIN = PLUGIN
PLUGIN.name = "EventAnnouncements"
PLUGIN.author = "cheerio1521"
PLUGIN.description = "A simple thing used for admins to do non-ic actions in chat, you don't have to credit me if your planning to use it."

if SERVER then
    ix.command.Add("event", {
        description = "Broadcast an event message.",
        adminOnly = true,
        arguments = ix.type.text,
        OnRun = function(self, client, message)
            if not message or message == "" then
                client:Notify("You must provide an event message.")
                return
            end
            
            net.Start("ixEventAnnouncement")
            net.WriteString(message)
            net.Broadcast()
        end
    })

    util.AddNetworkString("ixEventAnnouncement")
else
    net.Receive("ixEventAnnouncement", function()
        local message = net.ReadString()
        
        chat.AddText(Color(255, 165, 0), "[EVENT] ", Color(255, 200, 100), message)
    end)
end
