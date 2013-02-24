chan="#ccbots"
var http=require("http")
var irc=require("irc")
var url=require("url")
c=new irc.Client("irc.esper.net", "IGIRC", { channels: [chan] })
c.on("message#", function(nick, to, text, message){
lastmessage="<"+nick+"> "+text
})
lastmessage=""
server=http.createServer(function(req, res){
var u=url.parse(req.url, true)
if(u.pathname=="/send"){
if(u.query.msg){
c.say(chan, u.query.msg)
}
}else if(u.pathname=="/last"){
res.write(lastmessage)
}
res.end()
})

server.listen(8080)