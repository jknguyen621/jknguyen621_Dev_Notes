
public class Test2DSpiralPrintOut {

	public static final int X_SIZE = 4;
	public static final int Y_SIZE = 4;

	public static void main(String[] args) {
	    int[][] array = new int[X_SIZE][Y_SIZE];

        //Print out Visual Matrix
	    for(int i = 0; i < X_SIZE; i++){
	        for (int j = 0; j < Y_SIZE; j++){
	            array[i][j] = i * X_SIZE + (j + 1);
	            System.out.print(array[i][j] + " ");
	        } 
	        System.out.println();
	    }

	    System.out.println("************");
	    System.out.println("Spiral");       

	    spiralPrint(X_SIZE, Y_SIZE, array);
	}

	public static void spiralPrint(int xSize, int ySize, int matrix[][]){
	    int i,  k = 0, l = 0;
	    xSize--;  ySize--;      

	    while(k <= xSize && l <= ySize){
            
            //print: Down in Y
	        for(i = l; i <= ySize; ++i) {
	            System.out.print(matrix[k][i]+ " ");
	        }           
	        k++; //Increase Column count

            //print: Across Right in X
	        for(i = k; i <= xSize; ++i) {
	            System.out.print(matrix[i][ySize] + " ");
	        }
	        ySize--;  //Decrease Row Count

            //print: Up in Y
	        for(i = ySize; i >= l; --i) {
	                System.out.print(matrix[xSize][i] + " ");
	        }
	        xSize--;  //Decrease Column count

            //print: Across Left in X
	        for(i = xSize; i >= k; --i) {
	            System.out.print(matrix[i][l] + " ");
	        }
	        l++;  //Increase Row Count
	    }
	}
}
