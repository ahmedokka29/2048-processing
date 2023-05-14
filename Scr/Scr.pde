import ddf.minim.*;              //import libarary for sound 
/*-----------------------------------------------------------------------------------------
 Projet Name : 2048
 Team Num :   10
 Team Names: Ahmed Gamal - Ahmed Tarek - Abd AlRahman Atef - Ramzi Muhmmad - Ola Mohamed 
------------------------------------------------------------------------------------------*/

/*---------------------------Global Variables---------------------------------------------*/
int [][] board = new int[4][4];   //2D array
int boarder = 450;
int blockSize= 100;
int padding = 10;
int score = 0, move_possible =0;
int right, down;
String stage="menu";
color box2 = #EFE4DB;
color text2 = #766E64;
color box4 = #EEE1C9;
color text4 = #766E64;
color box8 = #F2B27B;
color text8 = #F9F6F2;
color box16 = #f59563;
color text16 = #f9f6f2;
color box32 = #F67C5E;
color text32 = #F9F6F2;
color box64 = #f65e3b;
color text64 = #f9f6f2;
color box128 = #edcf72;
color text128 = #f9f6f2;
color box256 = #edcc61;
color text256 = #f9f6f2;
color box512 = #edc850;
color text512 = #f9f6f2;
color box1024 = #edc53f;
color text1024 = #f9f6f2;
color box2048 = #edc22e;
color text2048 = #f9f6f2;
color box4096 = #181700;
color text4096 = #FFFFF2;
PImage img1;
PFont guide1, guide2, usual;
String how_to_play = "Use your arrow keys to move the tiles. Tiles with the same number merge into one when they touch. Add them up to reach 2048!";
color box_start = #8E7A67;
color text_start = #F9F6F2;
boolean sound_on=true;
Minim minim;
AudioPlayer losing, while_playing, win;
/*--------------------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------------Funcations-------------------------------------------------------------------*/

void setup() {
  size(475, 600);                        
  //frameRate(30);                 
  minim = new Minim(this);
  losing = minim.loadFile("mixkit-player-losing-or-failing-2042.wav"); // sound when the player lose
  losing.setGain(-12);           // -12 The sound level of the game
  while_playing = minim.loadFile("fireflies_karaoke_30sec.mp3");       // sound when the player play
  while_playing.setGain(-12);    // -12 The sound level of the game
  win = minim.loadFile("mixkit-video-game-win-2016.wav");              // sound when the player win
  win.setGain(-12);              // -12 The sound level of the game
  newgame();

  guide2=createFont("Segoe-Print-Font.ttf", 72);
  usual = createFont("impact.ttf", 72);
  textFont(usual, 20);
  background(#FAF9EE);
  noStroke();
  smooth();
}
/*----------------------------------------------------------------------------------------------------------------------*/
void draw() {

  if (stage=="menu") {     //Main Page
    img1 = loadImage("2048_logo.png");
    image(img1, 112.5, 12.5, 250, 250);
    fill(#766E64);
    textFont(guide2);
    textSize(24);
    text("How to play:", 87.5, 295);
    textFont(guide2);
    textSize(16);
    text(how_to_play, 87.5, 305, 300, 300);   //statment
    fill(box_start);
    rect(137.5, 475, 200, 50, 15);
    fill(text_start);
    textFont(usual);
    textSize(32);
    text("Start", 210, 480, 200, 50);
    textFont(usual);
    fill(box_start);
    textSize(28);
    text("press m to mute or unmute", 83.5, 575);
  }
  if (stage=="game") {   //when user press start

    background(#FAF9EE);
    fill(#BBACA1);                            
    rect(12.5, 90, boarder, boarder, 15);    //Main Border  .. 15 --> the round of the rectangle (strokejoin(ROUND))

    for (int j = 0; j < board.length; j++) {
      for (int i = 0; i < board.length; i++) {
        float x = 12.5+padding+(padding+blockSize)*i;  //12.5 padding with the window size . 10 padding with the border size
        float y = 90+padding+(padding+blockSize)*j;
        rec(x, y, blockSize, blockSize, 15, #CDC0B5);  // boxes border --> rec (x coordinate, y coordinate, width, height, radius of Round , color)
        if (board[j][i] == 2) {
          block_color(x, y, blockSize, blockSize, 15, box2); 
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text2);  // (textAlign , text , textSize , fill color)
        } else if (board[j][i] == 4) {
          block_color(x, y, blockSize, blockSize, 15, box4);
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text4);
        } else if (board[j][i] == 8) {
          block_color(x, y, blockSize, blockSize, 15, box8);
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text8);
        } else if (board[j][i] == 16) {
          block_color(x, y, blockSize, blockSize, 15, box16);
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text16);
        } else if (board[j][i] == 32) {
          block_color(x, y, blockSize, blockSize, 15, box32);
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text32);
        } else if (board[j][i] == 64) {
          block_color(x, y, blockSize, blockSize, 15, box64);
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text64);
        } else if (board[j][i] == 128) {
          block_color(x, y, blockSize, blockSize, 15, box128);
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text128);
        } else if (board[j][i] == 256) {
          block_color(x, y, blockSize, blockSize, 15, box256);
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text256);
        } else if (board[j][i] == 512) {
          block_color(x, y, blockSize, blockSize, 15, box512);
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text512);
        } else if (board[j][i] == 1024) {
          block_color(x, y, blockSize, blockSize, 15, box1024);
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text1024);
        } else if (board[j][i] == 2048) {
          block_color(x, y, blockSize, blockSize, 15, box2048);
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text2048);
        }
      }
    }
    fill(box_start);  //fill color of "New Game" box
    rect(15, 15, 200, 50, 15);
    fill(text_start); //fill color of "New Game" text
    textFont(usual);
    textSize(32);
    text("New Game", 20, 20, 200, 50);
    fill(box_start);
    textSize(28);
    text("press m to mute or unmute", 237.5, 575);
    // update in every play 
    update_score(score);
    game_over_text(move_possible);
    winning_text(check_winning());
  }
}
/*-------------------------------------------------------------------------------
[Function Name]: mousePressed
[Description]:   function to make check stage state
[Return]:        None
 ---------------------------------------------------------------------------------*/
public void mousePressed() {
  if (stage=="menu") {
    if (mouseX>137.5&&mouseX<337.5&&mouseY>475&&mouseY<525) {
      stage="game";
    }
  }
  if (stage =="game") {
    if (mouseX>15&&mouseX<215&&mouseY>15&&mouseY<65) {
      newgame();
    }
  }
}
/*-------------------------------------------------------------------------------
[Function Name]: newgame
[Description]:  prepare the variables to start new game
[Return]:       None
 ---------------------------------------------------------------------------------*/
void newgame() {
  losing.pause();
  while_playing.rewind();    //sets the file position to the beginning of the file of the given stream.      
  while_playing.play();      //Plays a sound one time and stops at the last frame.
  while_playing.loop();      //Repeat the sound in loop
  board = new int[4][4];
  score = 0;
  move_possible = 1;
  generate_block();                  //generate first block random
  generate_block();                  //generate second block random
  //board[0][0]=1024;                //test for when the game is won
  //board[0][3]=1024;
};
/*-------------------------------------------------------------------------------
[Function Name]: generate_block
[Description]:  generte  block 2 or 4 randomly
[Return]:       None
 ---------------------------------------------------------------------------------*/
void generate_block() {                                         
  ArrayList<Integer> column = new ArrayList<Integer>();     //column
  ArrayList<Integer> row = new ArrayList<Integer>();        //row

  for (int j = 0; j < board.length; j++) {    
    for (int i = 0; i < board.length; i++) {
      if (board[j][i]== 0) {     //remaining blocks with 0 
        column.add(i);
        row.add(j);
      }
    }
  }
  //x 0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3
  //y 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3
  int randnum = (int)random(0, row.size());  // column.size()=row.size()=16 and decrease while there are bloack != 0
  int x= column.get(randnum);
  int y= row.get(randnum);
  if (random(0, 2) < 1)   // generate num(2 or 4) block randomly .. random(0,2)       
    board[y][x] =2;
  else
    board[y][x] =4;
};
/*-------------------------------------------------------------------------------
[Function Name]: update_score
[Description]:   function that draws update_score
[Return]:       None
 ---------------------------------------------------------------------------------*/
void update_score (int score) {
  fill(box_start);
  text("Score: "+score, 225, 20, 250, 150);
  textSize(32);
};
/*-------------------------------------------------------------------------------
[Function Name]: game_over_text
[Description]:   function that draws 'GameOver' text if the condition is met
[Return]:       None
 ---------------------------------------------------------------------------------*/
void game_over_text(int moveposs) {   
  if (!check_winning()) {
    if (moveposs == 0) {
      if (while_playing.isPlaying()) {  // the sound of losing will play 
        while_playing.pause();
        losing.rewind(); //restart sound - Rewinds to the beginning. This does not stop playback.
        losing.play();
      }
      fill(187, 173, 160, 180);
      rect(12.5, 90, boarder, boarder, 15);
      fill(text_start);
      text("Gameover...!", width/2, 315, 30);
      textSize(36);
    }
  }
}
/*-------------------------------------------------------------------------------
[Function Name]: winning_text
[Description]:  function that draws 'you won' text
[Return]:       None
 ---------------------------------------------------------------------------------*/
void winning_text(boolean wonistrue) {  
  if (wonistrue == true) {
    if (while_playing.isPlaying()) {
      while_playing.pause();
      win.rewind();
      win.play();
    }
    move_possible = 0;
    fill(187, 173, 160, 180);
    rect(12.5, 90, boarder, boarder, 15);
    fill(text_start);
    text("YOU have WON!!!", width/2, 315, 30);
    textSize(36);
  }
}
/*-------------------------------------------------------------------------------
[Function Name]: check_winning
[Description]:  function that checks if the game is won
[Return]:       Boolean
 ---------------------------------------------------------------------------------*/
boolean check_winning() {  
  boolean Won = false;
  for (int j = 0; j < board.length; j++) {    
    for (int i = 0; i < board.length; i++) {
      if (board[j][i] >= 2048)
        Won = true;
    }
  }
  return Won;
}
/*-------------------------------------------------------------------------------
[Function Name]: no_game_over
[Description]:  conditions to check if the game is over
[Return]:       Boolean
 ---------------------------------------------------------------------------------*/
boolean no_game_over() {
  int [] Right = {1, -1, 0, 0}, Down = {0, 0, 1, -1};          //values for the up,down,left,right key.
  boolean gameover = false;
  // 1 0 right
  // -1 0 left
  // 0 1 down
  // 0 -1 up

  for (int i=0; i < 4; i++) {
    if (play(Down[i], Right[i], false) != null)           //If no movement is possible the function returns null 
      gameover = true;
  }
  return gameover;
};
/*-------------------------------------------------------------------------------
[Function Name]: keyPressed
[Description]:  function to  sound control , select the movement direction
[Return]:       None
 ---------------------------------------------------------------------------------*/
void keyPressed() {
  if (key=='m'||key=='M') sound_toggle();
  if (move_possible != 0) {
    switch (keyCode) { // (right=1 down=0) --> right , (right=-1 down=0) --> left , (right=0 down=1) --> down , (right=0 down=-1) --> up
    case 37://LEFT
      right = -1;
      down = 0;
      break;
    case 38://UP
      down =-1;
      right =0;
      break; 
    case 39://RIGHT
      right = 1;
      down = 0;
      break; 
    case 40://DOWN
      down = 1;
      right = 0;
      break; 
    default://no other keys can influence the movement
      down = 0;
      right = 0;
      break;
    }
    movement();              //slide the block if possible
    check_winning();           //check if the game is won
  }
  if (no_game_over()) {        //check if game over
    move_possible = 1;
  } else
    move_possible = 0;
}
/*-------------------------------------------------------------------------------
[Function Name]: movement
[Description]:  
[Return]:       Boolean
 ---------------------------------------------------------------------------------*/
boolean movement() {
  int[][] newboard  = play(down, right, true);
  if (newboard != null) {
    board = newboard;
    generate_block();
    return true;
  } else
    return false;
} 
/*-------------------------------------------------------------------------------
[Function Name]: Play
[Description]:  main function 
[Return]:       Int
 ---------------------------------------------------------------------------------*/
int[][] play(int vertical, int horizontal, boolean scoreupdate) {
  //  left  --> (vertical =  0, horizontal= -1)  (<)
  //  right --> (vertical =  0, horizontal=  1)  (>)
  //  down  --> (vertical =  1, horizontal=  0)  (v)                                         
  //  up    --> (vertical = -1, horizontal=  0)  (^)
  
  // example : Left 

  int[][] backup = new int[4][4];    //make a backup copy of the board
  boolean moved =false;

  for (int j = 0; j < board.length; j++) {    
    for (int i = 0; i < board.length; i++) {
      backup[j][i] = board[j][i];    //copy the current board
    }
  }
    // true step_direction = horizontal     
    // false step_direction = vertical 
    // step direction contain -1 or 1
    //slide all the blocks to the corresponding directions(up,down,right,left)
  if (vertical !=0 || horizontal !=0) {      //
    int step_direction = horizontal !=0 ? horizontal : vertical;  

    //(step_direction > 0) == true  --> means there is move right or down 2 1 0 , till -1 
    //(step_direction > 0) == false --> means there is move left or up    1 2 3 , till 4
    

    for (int n_row = 0; n_row < board.length; n_row++)
      for (int n_column = (step_direction > 0 ? board.length-2 : 1); n_column != (step_direction > 0 ? -1: board.length); n_column -= step_direction) {//nth-cloumn (n=0,1,2,3)
        int y = horizontal != 0 ? n_row : n_column;                //determine the coordinate xy of the block for (right and left) and (up and down)
        int x = horizontal != 0 ? n_column : n_row;
        int dy = y;                                                   //change in the direction -y     
        int dx = x;                                                   //change in the direction -x 

        //if the column is zero then skip the steps to the next column
        if (backup[y][x]==0) continue;

        //calculate how many blocks the current block should slide in the direction
        //x and y are the current block position, dx and dy are where the block is sliding into
        for (int i = (horizontal != 0 ? x : y)+step_direction; i != (step_direction > 0 ? board.length : -1); i+=step_direction) {
          int a = horizontal != 0 ? y : i;                          //xy-coordinate
          int b = horizontal != 0 ? i : x;
        /*x = 2 y=2      a = 2  b =1      */
          //stop the slide if blocks are not empty and the value is not equal
          if (backup[a][b] != 0 && backup[a][b] != board[y][x]) break;
          //change in direction
          if (horizontal != 0) 
            dx = i;
          else
            dy = i;
        }
        //if the block stays at the same positon;no movement in that direction,then  skip
        if ((horizontal != 0 && dx == x) || (vertical != 0 && dy == y)) continue;

        //if the block moves into new position then merge the blocks if their number is same
        else if (backup[dy][dx] == board[y][x]) {                    //means blocks are equal
          backup[dy][dx] *= 2;                                       //times 2
          if (scoreupdate) 
            score += backup[dy][dx];
          moved =true;
        }
        //switch the block with the empty position
        else if ((horizontal != 0 && dx != x ) || (vertical !=0 && dy != y)) { 
          backup[dy][dx] = backup[y][x];
          moved =true;
        }
        if (moved)                                
          backup[y][x]= 0;                       //clear the block
      }
  }
  return moved ? backup : null;
}
/*-------------------------------------------------------------------------------
[Function Name]: rec
[Description]:   function to make custom rectangle
[Return]:       None
 ---------------------------------------------------------------------------------*/
void rec (float rec_x, float rec_y, float rec_width, float rec_height, float radius, color clr)
{
  fill(clr);
  rect(rec_x, rec_y, rec_width, rec_height, radius);
};

/*-------------------------------------------------------------------------------
[Function Name]: block_color
[Description]:   function to make custom block color 
[Return]:        None
 ---------------------------------------------------------------------------------*/
void block_color (float x_rect, float y_rect, float width_rect, float height_rect, float radius_rect, color cB) {
  rec (x_rect, y_rect, width_rect, height_rect, radius_rect, cB);
};
/*-------------------------------------------------------------------------------
[Function Name]: block_text
[Description]:   function to make custom block text 
[Return]:        None
 ---------------------------------------------------------------------------------*/
void block_text(int align, String text_string, float text_x, float text_y, float text_width, float text_height, float text_Size, color cT) {
  fill(cT);
  textAlign(align);
  textSize(text_Size);
  text(text_string, text_x, text_y+2, text_width, text_height);
};

/*-------------------------------------------------------------------------------
[Function Name]: sound_toggle
[Description]:  function to toggle the state of sound
[Return]:       none
 ---------------------------------------------------------------------------------*/
public void sound_toggle() {
  sound_on=!sound_on;
  sound_control();
}
/*-------------------------------------------------------------------------------
[Function Name]: sound_control
[Description]:  function to make mute or unmute
[Return]:       None
 ---------------------------------------------------------------------------------*/
public void sound_control() {
  if (!sound_on) {
    win.mute();
    while_playing.mute();
    losing.mute();
    }
  if (sound_on) {
    win.unmute();
    while_playing.unmute();
    losing.unmute();
  }
}
/*-------------------------------------------------------------------------------------------------------------------------------------*/
