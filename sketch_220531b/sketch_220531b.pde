ArrayList<Points> points;

boolean home = true;
boolean shapeDraw = false;
boolean shape3D = false;
boolean bHelp = false;
boolean draw = false;

String description;
String desHelp;
String desShape;
String help;
String getShape;
String back;

PShape TwoDshape;
PShape ThreeDshape;

void setup() {
  size(600, 600,P3D);
  
  description = "Esta herramienta te permite crear una figura 3D a partir de una 2D. Para obtenerla primero deberá dibujar con el raton el perfil de la figura y posteriormente pulsar en el boton de 'GetShape'";
  desShape = "Para crear una figura pulse 's'";
  desHelp = "Si tiene alguna duda pulse la tecla 'h' para obtener ayuda";
  help = "Para dibujar la figura deberá mantener el 'mouse' pulsado y deslizar como si fuera un lapiz. Todo esto se debe realizar en el lado derecho de la pantalla, tomando la linea como principio del lienzo.";
  getShape = "Get Shape";
  back = "Para volver atrás pulse la tecla 'a'";
 
  points = new ArrayList<Points>();
}


void draw() {
  fill(0);
  
  if(home){
    background(0);
    
    
    
    fill(255);
    textSize(25);
    text("Shape Generator", width/3 - 10, 80);
    textSize(15);
    text(description, width/9 - 10, height/4, 400, 320);
    text(desShape, width/9 - 10, height - 125, 400, 320);
    text(desHelp, width/9 - 10, height - 100, 400, 320);
    
    if(key == 's'){
       home = false;
       shapeDraw = true;
     } 
      
   if(key == 'h'){
       home = false;
       bHelp = true;
   }
  
  }
  
  if(bHelp){
    background(0);
    
    fill(255);
    textSize(25);
    text("Menu Ayuda", width/3 - 10, 80);
    textSize(15);
    text(help, width/9 - 10, height/4, 400, 320);
    text(back, width/9 - 10, height - 125, 400, 320);
    
    if(key == 'a'){
       bHelp = false;
       home = true;
     } 
  }
   
  if(shapeDraw){
    background(0);
    stroke(255);
    line (height/2,0,height/2,height);
     
    if(mousePressed && mouseX>(height/2)){
      points.add(new Points(mouseX, mouseY));
      draw = true;
     }
      
   } 
  
   TwoDshape = createShape();
   TwoDshape.beginShape();
   TwoDshape.stroke(255);
   TwoDshape.strokeWeight(3);
   TwoDshape.noFill();
   
   for(Points c : points){
      TwoDshape.vertex(c.getX(), c.getY());
   }    
   TwoDshape.endShape();
     
   if(shape3D == false) shape(TwoDshape);  
   
   if(mousePressed == false && draw == true){
     shapeDraw = false;
     shape3D = true;
   }
     
  if(shape3D){
    
    ThreeDshape = createShape();
    ThreeDshape.beginShape(TRIANGLE_STRIP);
    ThreeDshape.stroke(223, 66, 24);      
    ThreeDshape.strokeWeight(1);
    ThreeDshape.fill(255);
    
    for(int i = 0; i < TwoDshape.getVertexCount(); i++){
      PVector vertx = TwoDshape.getVertex(i);
      vertx.x -= width/2;
      vertx.y -= height/2;  
      TwoDshape.setVertex(i, vertx.x, vertx.y, vertx.z);
    }
    
    for (int i=0; i < TwoDshape.getVertexCount()-1; i++){
      PVector vert = TwoDshape.getVertex(i);
      PVector vertNext = TwoDshape.getVertex(i + 1);  
      
      for (int theta = 0; theta < 180; theta++){   
        float xa = vert.x;
        float za =vert.z;           
        vert.x = xa * cos(theta) - za * sin(theta);
        vert.z = xa * sin(theta) + za * cos(theta);
        ThreeDshape.vertex(vert.x, vert.y, vert.z);           
        
        float xb = vertNext.x;
        float zb = vertNext.z;
        vertNext.x = xb * cos(theta) - zb * sin(theta);
        vertNext.z = xb * sin(theta) + zb * cos(theta);
        ThreeDshape.vertex(vertNext.x, vertNext.y, vertNext.z);        
      }
    }
    
    
    
    ThreeDshape.endShape();
    translate(width/2, height/2);
    if(shape3D)shape(ThreeDshape);    
  } 
    
  
  
  
}
  
  
  
 
