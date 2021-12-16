import processing.sound.*;
int x=450;
int y=450;
int mode=0;
PGraphics pg;
PGraphics pg1;
PGraphics pgb;
PGraphics bckgrnd;
PImage img;
PImage mario;
SoundFile mySoundFile;
SoundFile bshell;
int locx=950;
int locy=700;
int point=0;
int hit=0;
int ammo=100;
int step=5;
int lvl=1;
int sblt=0;
int lvlchng=5;

void setup()
{
  size(1000,1000);
  pg=createGraphics(1000,1000);
  pg1=createGraphics(1000,1000);
  pgb=createGraphics(1000,1000);
  bckgrnd=createGraphics(1000,1000);
  img=loadImage("bullet.png");
  mario=loadImage("mario.png");
  mySoundFile = new SoundFile(this, "gshot.mp3");
  bshell = new SoundFile(this, "bshell.mp3");
  makeBackground();
  locReset();
}

void draw()
{
  noCursor();
  clear();
  if(sblt==1) sblt=2;
  if(sblt==2)
  {
    pgb.beginDraw();
    pgb.clear();
    pgb.endDraw();
    sblt=0;
  }
  noFill();
  showStat();
  image(bckgrnd,0,0);
  image(pg,0,0);
  image(pg1,0,0);
  image(pgb,0,0);
  showCrossHair();
  showMario();
  x=mouseX;
  y=mouseY;
   
}

void showMario()
{
  pg.beginDraw();
  locx=locx-step;
  if(locx<0) locReset();
  pg.clear();
  pg.image(mario,locx,locy);
  pg.endDraw();
}

void mousePressed()
{
    int lx=locx;
    int ly=locy;
    pgb.beginDraw();
    if(ammo>0)
    {
      pgb.image(img,x-34,y-34);
      sblt=1;
      mySoundFile.play();
      //while(mySoundFile.isPlaying());
      delay(10);
      bshell.play();
      ammo--;
      if(x>lx&&x<lx+65&&y>ly&&y<ly+90)
      {  
        point++;
        locReset();
        if(point%10==0) 
        {
          step+=lvlchng;
          lvl++;
        }
      }
    }
  pgb.endDraw(); 
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e>0) mode++;
  if(e<0) mode--;
  if(mode==6) mode=0;
  if(mode==-1) mode=5;
}

void showCrossHair()
{
  if(mode==0)
  {
  stroke(0,255,0);
  circle(x,y,70);
  circle(x,y,30);
  line(x-40,y,x+40,y);
  line(x,y-40,x,y+40);
  }
  if(mode==1)
  {
    stroke(0,255,0);
    circle(x,y,70);
    strokeWeight(3);
    line(x-35,y,x-25,y);
    line(x+35,y,x+25,y);
    line(x,y-35,x,y-25);
    line(x,y+35,x,y+25);
    strokeWeight(1);
  }
  if(mode==2)
  {
    stroke(0,255,0);
    circle(x,y,70);
    line(x+40,y,x+10,y);
    line(x-40,y,x-10,y);
    line(x,y+40,x,y+10);
    line(x,y-40,x,y-10);
  }
  if(mode==3)
  {
    stroke(0,255,0);
    circle(x,y,70);
    line(x+40,y,x+10,y);
    line(x-40,y,x-10,y);
    line(x,y+40,x,y+10);
    line(x,y-40,x,y-10);
    stroke(255,0,0);
    fill(color(255,0,0));
    circle(x,y,5);
    noFill();
  }
  if(mode==4)
  {
    stroke(0,255,0);
    circle(x,y,70);
    stroke(255,0,0);
    fill(color(255,0,0));
    circle(x,y,5);
    noFill();
  }
  if(mode==5)
  {
    stroke(0,255,0);
    circle(x,y,70);
    line(x+40,y,x+10,y);
    line(x-40,y,x-10,y);
    line(x,y+40,x,y+10);
    fill(color(0,255,0));
    circle(x,y,5);
    noFill();
  }
}

void locReset()
{
  locx=950;
  locy=700;
}

void showStat()
{
    pg1.beginDraw();
    pg1.clear();
    pg1.textSize(40);
    String k="Hits "+point+" Ammo "+ammo+" Level "+lvl;
    if(ammo<=0) k="Hits "+point+" Out of Ammo. Game Over.";
    pg1.text(k,10,90);
    pg1.endDraw();
}

void makeBackground()
{
  bckgrnd.beginDraw();
  bckgrnd.fill(8,9,55);
  bckgrnd.rect(0,0,1000,790);
  bckgrnd.noFill();
  bckgrnd.strokeWeight(3);
  bckgrnd.stroke(color(255,255,255));
  bckgrnd.line(0,790,1000,790);
  bckgrnd.line(0,900,1000,900);
  bckgrnd.noStroke();
  bckgrnd.fill(color(82,82,82));
  bckgrnd.rect(0,790,1000,110);
  bckgrnd.noFill();
  makeMoon();
  makeStars();
  for(int tx=30;tx<1000;tx+=70)
  {
    makeTree(tx,710);
  }
  bckgrnd.endDraw();
}

void makeTree(int a, int b)
{
  bckgrnd.noStroke();
  bckgrnd.fill(color(82,48,37));
  bckgrnd.rect(a,b,20,80);
  bckgrnd.fill(color(0,255,0));
  bckgrnd.circle(a+10,b,40);
  for(float ang=0;ang<=2*PI;ang+=0.9)
  {
    bckgrnd.circle(a+10+20*cos(ang),b+20*sin(ang),20);
  }
  bckgrnd.noFill();
}

void makeMoon()
{
  bckgrnd.fill(243,217,47);
  bckgrnd.circle(200,200,100);
  bckgrnd.fill(8,9,55);
  bckgrnd.circle(220,180,100);
}

void makeStar(int a, int b)
{
  bckgrnd.fill(243,217,47);
  bckgrnd.circle(a,b,10);
  bckgrnd.strokeWeight(2);
  bckgrnd.stroke(color(243,217,47));
  bckgrnd.line(a-7,b,a+7,b);
  bckgrnd.line(a-7,b-7,a+7,b+7);
  bckgrnd.line(a,b-7,a,b+7);
  bckgrnd.line(a+7,b-7,a-7,b+7);
}

void makeStars()
{
  for(int i=0;i<30;i++)
  {
    int sx=(int)(Math.random()*1000);
    int sy=(int)(Math.random()*700);
    makeStar(sx,sy);
  }
}
