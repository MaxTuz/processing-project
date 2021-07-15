import controlP5.*;
import processing.net.*;

Server myServer;
int val = 0;
PImage img;
ControlP5 cp5;
Textarea myTextarea;
PFont font;
Client thisClient;

void setup() {
  size(736, 460);
  // Starts a myServer on port 5204 
  
  img = loadImage("kosmos_1.png");
  cp5 = new ControlP5(this);
  
  cp5.addButton("Start")
     .setValue(0)
     .setPosition(10,10)
     .setSize(150,25)
     ;
  cp5.addButton("Stop")
     .setValue(0)
     .setPosition(10,45)
     .setSize(150,25)
     ;
  cp5.addTextfield("Host")
     .setPosition(170,10)
     .setSize(150,25)
     .setFont(createFont("arial",10))
     .setAutoClear(false)
     .setText("192.168.88.234") 
     ;
  cp5.addTextfield("Port")
     .setPosition(330,10)
     .setSize(150,25)
     .setFont(createFont("arial",10))
     .setAutoClear(false)
     .setText("5555") 
     .setColorValue(255)
     ;
     
  myTextarea = cp5.addTextarea("Text")
     .setPosition(10,80)
     .setSize(716,300)
     .setFont(createFont("arial",12))
     .setLineHeight(14)
     .setColor(color(255))
     .setColorBackground(color(255,100))
     .setColorForeground(color(255,100))
     ;
  cp5.addButton("Send")
     .setValue(0)
     .setPosition(10,390)
     .setSize(150,25)
     ;
  cp5.addTextfield("Sent")
     .setPosition(170,390)
     .setSize(350,25)
     .setFont(createFont("arial",10))
     .setAutoClear(false)
     .setText("send") 
     .setColor(color(128))
     .setColorBackground(color(255,100))
     .setColorForeground(color(255,100))
     .setColorValue(0)
     ;
     
   int port_server = int(cp5.get(Textfield.class,"Port").getText());
   myServer = new Server(this, port_server);
   myServer.stop();

}

public void Start(int theValue) {
   int port_server = int(cp5.get(Textfield.class,"Port").getText());
   myServer = new Server(this, port_server);
   myServer.active();
   myTextarea.append("Start server \n"); 
}

public void Stop(int theValue) {
 //  int port_server = int(cp5.get(Textfield.class,"Port").getText());
 //  myServer = new Server(this, port_server);
   myServer.stop();
   myTextarea.append("Stop server \n");
}

public void Send(int theValue){
   myServer.write(cp5.get(Textfield.class,"Sent").getText());
   //println(thisClient.ip() + " -> " + whatClientSaid);
   myTextarea.append(" <- " + (cp5.get(Textfield.class,"Sent").getText()) + "\n");
   cp5.get(Textfield.class,"Sent").setText(""); 
}

void draw() {
  image(img, 0, 0);
  val = (val + 1) % 255;
  background(val);
  background(img);
   //int port_server = int(cp5.get(Textfield.class,"Port").getText());
  // myServer = new Server(this, port_server);
  // myServer.active();
  // myTextarea.append("Start server \n");
  Client thisClient = myServer.available();
    if (thisClient !=null) {
    String whatClientSaid = thisClient.readString();
    if (whatClientSaid != null) {
      println(thisClient.ip() + " -> " + whatClientSaid);
      myTextarea.append(thisClient.ip() + " -> " + whatClientSaid + "\n");
    } 
  }
}
