import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 50;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );

    //declare and initialize buttons
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int row = 0; row < NUM_ROWS; row ++) {
        for (int col = 0; col < NUM_COLS; col ++) {
            buttons[row][col]=new MSButton(row, col);
        }  
    }
    setBombs();
}
public void setBombs()
{
      while(bombs.size() < NUM_BOMBS) {
        int r = (int)(Math.random()*NUM_ROWS);
        int c = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[r][c])){
            bombs.add(buttons[r][c]);
            // System.out.println(r + ", " + c);
            // System.out.println("size " + bombs.size());
        }
        
      }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    /*if(bombs.contains()){
        return true;
        displayWinningMessage();
    }*/
    return false;
}
public void displayLosingMessage()
{
    //buttons.setLabel("Game Over");
}
public void displayWinningMessage()
{
    //buttons.setLabel("Winner");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed() 
    {
        clicked = true;
        if(mouseButton == RIGHT){marked = !marked;}
        else if(bombs.contains(this)){displayLosingMessage();}
        else if(countBombs(r,c) > 0){setLabel("" + countBombs(r,c));}
        else{
            if(isValid(r-1,c) && buttons[r-1][c].isClicked() == false){buttons[r-1][c].mousePressed();}
            if(isValid(r+1,c) && buttons[r+1][c].isClicked() == false){buttons[r+1][c].mousePressed();}
            if(isValid(r,c-1) && buttons[r][c-1].isClicked() == false){buttons[r][c-1].mousePressed();}
            if(isValid(r,c+1) && buttons[r][c+1].isClicked() == false){buttons[r][c+1].mousePressed();}
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
      if(r >= 0 && r < NUM_ROWS){
        if(c >= 0 && c < NUM_COLS){return true;}
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        // System.out.println(numBombs);
        return numBombs;
    }
}
