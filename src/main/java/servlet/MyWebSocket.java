package servlet;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Set;

@ServerEndpoint("/chat")
public class MyWebSocket {

    @OnOpen
    public void connectionOpened() {
        System.out.println("Connection opened");
    }

    @OnMessage
    public void messageReceived(String message, Session session) {
        System.out.println("Message received:" + message);

        // here we broadcast the message received
        // to all others active connection (browser)
        Set<Session> sessions = session.getOpenSessions();
        for (Session oneSession: sessions) {
            if (!oneSession.equals(session)) {
                try {
                    // send message to client connected
                    oneSession.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
