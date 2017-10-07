import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.StringTokenizer;

import MyJavaUtilitiesClass.MyJavaUtilitiesClass;


public class TestDriver {

		/**
		 * @author josnguyen
		 * @date June 28 2011
		 * @param args
		 * @throws Exception
		 */
		public static void main(String[] args) throws Exception {
			// TODO Auto-generated method stub

			//Test Long to long conversion
			try {
				
				//MyJavaUtilitiesClass testClass = new MyJavaUtilitiesClass();
				System.out.printf("\nTesitng Long to long conversion and printout...\n");
				String testValueX = "1844674407370955155";
				long longValue = MyJavaUtilitiesClass.convertLong(testValueX);
				System.out.printf("long value is %d\n", longValue);
				
				/* //Testing calling reverse string
		        String myTestString = "Test Me";
		        System.out.printf("Calling reverseString() for: %s\n", myTestString);
		        String reversed =  MyJavaUtilitiesClass.reverseString(myTestString);
		        System.out.println(reversed);

		        //Testing Tokenizer
		        String TestString = "The End of Time";
		        System.out.printf("Calling myTokenizer() for: %s\n", TestString);
		        StringTokenizer tokens = MyJavaUtilitiesClass.myTokenizer(TestString);

		        //Testing Reverse a sentence
		        String palindrome = "Please Reverese My String";
		        System.out.printf("Calling reverseEntireString: %s\n", palindrome);
		        String myReversed = MyJavaUtilitiesClass.reverseEntireString(palindrome);
		        System.out.printf("Returned Value is: %s\n", myReversed);

		        //Testing reverse String by word boundary
		        TestString = "What in the name is this reverse business?";
		        System.out.printf("Calling reverseEntierStringByWord with %s\n", TestString);
		        String newString = MyJavaUtilitiesClass.reverseEntireStringByWord(TestString);
		        System.out.printf("Returned reversed by word string is: %s\n", newString);
		   */
		        //Testing Reading in User's list into Hashtable
				System.out.printf("\nTesting Reading in User's Prop file...\n");
		        Hashtable <String, String> myHash = MyJavaUtilitiesClass.getUserProperties("..//MyJavaUtilitiesClass//src//MyJavaUtilitiesClass//testCSV.csv", ",");
		        
		        Enumeration e = myHash.keys();
		        String value="";
		        while( e.hasMoreElements() )         
		        {
		        	System.out.printf("Key is: %s \t", e.toString());
		        	value = myHash.get(e.nextElement()); //get value to set to
		        	System.out.printf("Value is: %s\n", value);
				}
				
		        
		        //Testing of removal of duplicates of integer
		        System.out.printf("\nTesting of removal of Duplicates...\n");
		        Integer [] testArray = {4,6,7,8,4,5,4,3,1};
		        ArrayList<Integer> reducedList = MyJavaUtilitiesClass.removeDuplicates(testArray);
		        int inputSize = testArray.length;
		        System.out.printf("Input Size is: %d\n", inputSize);
		        for(int j=0; j<inputSize; j++)
		        {
		        	 System.out.printf("Input [%d] is: %d\n", j, testArray[j]);
		        }
		        int size = reducedList.size();
		        System.out.printf("Reduced Size is: %d\n", size);
		        for(int i=0; i<size; i++)
		        {
		        	System.out.printf("RL: %d ", reducedList.get(i));
		        }
		        
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
}
