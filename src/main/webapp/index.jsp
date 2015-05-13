<html>
<head>
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            background-color: lightgrey;
            padding: 20px;
        }
        .wrapper {
            border-radius: 10px;
            background-color: white;
            width: 80%;
            height: 90%;
            border: 3px solid gray;
            left: 10%;
            position: absolute;
            padding: 10px;
            overflow: hidden;
        }
        .listview {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        .lv-messages {
            overflow-y: scroll;
            overflow-x: hidden;
            padding-top: 50px;
            padding-bottom: 80px;
            height: 100%;
        }
        .lv-body {
            padding: 5px;
        }
        .lv-message {
            background-color: lightblue;
            border-radius: 10px;
            padding: 10px;
            font-family: 'DejaVu Sans Mono', monospace;
            font-size: large;
            display: inline-block;
        }
        .lv-right {
            text-align: right;
        }
        .lv-me {
            background-color: lightgreen;
        }
        .lv-header {
            font-family: Arial, Helvetica, sans-serif;
            font-size: x-large;
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
            color: royalblue;
            top: 0px;
            width: 100%;
            height: 50px;
            padding: 10px;
            background-color: white;
            position: absolute;
        }
        .lv-footer {
            font-family: 'DejaVu Sans Mono', monospace;
            font-size: large;
            text-align: center;
            position: absolute;
            height: 80px;
            padding: 15px;
            bottom: 0px;
            width: 100%;
            margin-top: 10px;
            text-align: left;
            background-color: white;
        }
        .lv-footer input {
            font-family: 'DejaVu Sans Mono', monospace;
            font-size: large;
            width: 70%;
            border-radius: 10px;
            border: 1px solid silver;
            padding: 10px;
        }
        .lv-footer button {
            font-family: 'DejaVu Sans Mono', monospace;
            font-size: large;
            border-radius: 10px;
            border: 1px solid silver;
            padding: 10px;

        }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="listview">
            <div class="lv-header">
                Awesome chat app
            </div>
            <div id="messages" class="lv-messages">
            </div>
            <div class="lv-footer">
                <form onsubmit="sendMessage(); return false">
                    <input type="text" id="text" />
                    <button type="submit">Send</button>
                </form>
            </div>
        </div>
    </div>

    <script type="application/javascript">
        var webSocket = new WebSocket("ws://localhost:8080/chat");
        webSocket.onopen = function(event) {
            addMessage("Welcome to chat", false)
        }
        webSocket.onmessage = function (event) {
            addMessage(event.data, false)
        }

        function sendMessage() {
            var text = document.getElementById('text').value;
            webSocket.send(text);
            addMessage(text, true)
            document.getElementById('text').value = '';
        }

        function addMessage(text, me) {
            var html = '<div class="lv-body' + (me ? ' lv-right':'') + '">';
            html += '<div class="lv-message' + (me ? ' lv-me':'') + '">';
            html += text + '</div></div>';
            document.getElementById('messages').innerHTML += html;
            document.getElementById('messages').scrollTop = document.getElementById('messages').scrollHeight;
        }
    </script>

</body>
</html>
