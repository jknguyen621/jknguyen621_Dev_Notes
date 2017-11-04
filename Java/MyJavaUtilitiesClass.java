package MyJavaUtilitiesClass;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.StringTokenizer;
import java.util.Map;
import java.util.Iterator;
import java.util.HashMap;

/**
 * 
 * @author joseph_Nguyen
 * @date June 28th, 2011
 */

public class MyJavaUtilitiesClass {

	
	/**
	 * @NOTE: Key is to Long's class method of longValue() to return the primitive type long value.
	 * @param Long
	 * @return
	 */
	public static long convertLong(String myLong)
	{
		//Testing converting String representation of Long and printing out as Long
		//String testValueX = "1844674407370955155";  //Largest 63 bit number
		Long testdata = new Long(myLong);
		long myLong2 = testdata.longValue();
		System.out.printf("%d \n", myLong2);
		return myLong2;
	}
	
	/**
	 * @NOTE: Key is to use ArrayList and contains checking method to validate before adding
	 * @param testArray
	 * @return
	 */
	public static ArrayList<Integer> removeDuplicates(Integer[] testArray)
	{
		//Integer [] testArray = {4,6,7,8,4,5,4,3,1};
		ArrayList<Integer> arrListInt =  new ArrayList<Integer> ();
		
		int len = testArray.length;
		for(int i=0; i <len; i++)
		{
			if (!(arrListInt.contains(testArray[i])))
			{
				arrListInt.add(testArray[i]);
			}
		}
	
		return arrListInt;	
	}
	
	/**
	 * Util to read in user's property files, separated by delimiter, return a Prop list via Hashtable
	 * @NOTE: Key is to Hashtable and StringTokenizer
	 * @param fileName
	 * @return
	 * @throws Exception
	 */
	public static  Hashtable <String, String> getUserProperties(String fileName, String delimiter) throws Exception
	{
		FileReader fr = new FileReader(fileName);
		BufferedReader br = new BufferedReader(fr);
		String line = null;
		Hashtable userProps = new Hashtable<String, String>();
		
		try {
			
			while((line = br.readLine() ) != null)
			{
				StringTokenizer st = new StringTokenizer(line, delimiter);
				while(st.hasMoreTokens())
				{
					userProps.put(st.toString(), st.nextToken());
				}
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally {
			fr.close();
			br.close();
		}
		return userProps;
	}
	
    
    /**
     *  Illustration of Collection's iteration through a Map/Hashmap/Hashtable
     *  of map of certain checkboxes, to verify if they are checked.
     *  Checkbox names are the keys.
     *  Checked states are in boolean and are the values,
     **/
    public boolean verifyCheckBoxChecked(Map<String, Boolean> expectedHT) throws Exception {
        boolean status = true;
        
        Iterator<String> keys = expectedHT.keySet().iterator();
        String key = "";
        boolean expected = false;
        
        while (keys.hasNext()) {
            key = (String) keys.next();
            log("Verifying Checkbox Checked for: " + key, true);
            System.out.printf("Key is: %s \n", key);
            expected = (boolean) expectedHT.get(key);
            assertTrue(verifyChecked(key, expected), "CheckBox is not Checked" + key);
        }
        
        return status;
    }
    

	/**
	 * @NOTE: Key is to use String's method of toCharArray() & use two char[],
	 * then you can reverse index and copy over.
	 * @param originalString
	 * @return
	 */
    public static String reverseString(String originalString)
    {
        int i = originalString.length();

        char[] original = originalString.toCharArray();  //Trick here is to use String.toCharArray()
        char[] reversed = new char[i];
        int index = i-1;
        for(int j=0; j<i; j++)
        {
            reversed[j] = original[index];
            index--;
        }
        String reversedString = new String (reversed);   //NOTE: char.toString() does per char conversion to string equivalent
       //System.out.println(reversedString);
        return reversedString;
    }

    /**
     * @NOTE: Key is to use String's replaceAll() method.
     * @param input
     * @param tokenOut
     * @param tokenIn
     * @return
     */
    public static String replaceAll(String input, String tokenOut, String tokenIn)
    {
    
    		//String test = "SMEditProduct.setValueAndSubmitFormEditTemplate(\"prodModifyForm\", \"editButtonTemplate1\", \"editButtonTemplate1\", \"templateId1\", \"6009283015\")";

    		//String delims = "[, ]";
    		//String[] tokens = input.split(delimiter);

    		//String item = tokens[tokens.length-1];
    		String outString = input.replaceAll(tokenOut, tokenIn);
    		System.out.printf("New String out is: %s\n", outString);
    		
    		return outString;
    	
    }

    /**
     * 
     * @param original
     * @return
     */
    public static String[] splitString(String original)
    {
        String [] words =  original.split(original);
        return words;
    }

    
    /**
     * 
     * @param inputString
     * @return
     */
    public static StringTokenizer myTokenizer(String inputString) 
    {
        StringTokenizer tokens = new StringTokenizer(inputString);  //trick is to use StringTokenizer
        System.out.printf("Token 1 is: %s\n", tokens.nextToken());  //get individual element by tokens.nextToken()
        System.out.printf("Token 2 is: %s\n", tokens.nextToken());
         System.out.printf("Token 3 is: %s\n", tokens.nextToken());
          System.out.printf("Token 4 is: %s\n", tokens.nextToken());
         // for( (String token=tokens.nextToken) : tokens)
         // {
         //      System.out.printf("Token XX is: %s\n", tokens.nextToken());
         // }
        return tokens;
    }

    /**
     * @NOTE: trick is to use 2 char array, one to store original string by string.charAt[i] via looping
     * then a second loop to index from len-1-j into j of new array... and then convert charArray to back to string
     * @param myString
     * @return
     */
    public static String reverseEntireString(String myString)
    {
        int len = myString.length();
        char[] tempCharArray = new char[len];  //trick is to use 2 char array, one to store original string by string.charAt[i] via looping
        char[] charArray = new char[len];      //then a second loop to index from len-1-j into j of new array... and then convert charArray to back to string

        // put original string in an array of chars
        for (int i = 0; i < len; i++) {
                tempCharArray[i] = myString.charAt(i);
        }

        // reverse array of chars
        for (int j = 0; j < len; j++) {
                charArray[j] = tempCharArray[len - 1 - j];
        }

        String reversePalindrome =  new String(charArray);
        System.out.println(reversePalindrome);
         return reversePalindrome;
    }

    /**
     * 
     * @param myString
     * @return
     */
    public static String reverseEntireStringByWord(String myString)
    {
        String [] words = splitString(myString);
        int count = words.length;
        for(int i=0;i< count-1; i++)
        {
            words[i] = reverseString(words[i]);
        }
        String testingReverse = words[0];
        System.out.printf("Inside Revere, test Reverse by word is: %s\n", testingReverse);
        
         String reversedByWordString = unSplitString(words, ' ');
          System.out.printf("Inside reverseEntireStringByWord:  \'%s\'", reversedByWordString);
         return reversedByWordString;
    }

    /**
     *  
     * @param words
     * @param delimiter
     * @return
     */
    public static String unSplitString(String [] words, char delimiter)
    {
        String newString = "";
        int i = words.length;
        for(int j=0; j<i-1; j++)
        {
            newString += words[j]+delimiter;
        }
        System.out.printf("Inside unSplitString:  \'%s\'", newString);

        return newString;
    }
    
    
	/**
	 * 
	 * @param input
	 * @return
	 */
	public static String parseJavaScriptForItem (String input)
	{
		String delims = "[, ]";
		String[] tokens = input.split(delims);

		String item = tokens[tokens.length-1];
		String newItem = item.replaceAll("\"", "");
		String newItem2 = newItem.replace(")", "");

		System.out.printf("Template ID is: %s\n", newItem2);

		return newItem2;
	}
	
	/**
	 * 
	 * @param url
	 * @return
	 */
	public static String parse4ProductdID(String url)
	{
		String[] tokens = url.split("[&]");
		String item = tokens[tokens.length-2];
	
		String groupID = item.replace("smProductId=", "");
		System.out.printf("GroupdID of product is: %s\n", groupID);
		return groupID;
	}
	
	/**
	 * 
	 * @param partialFile
	 * @param goldenFile
	 * @throws IOException
	 */
	public static void fileSubStringComparisionUtil (String partialFile, String goldenFile) throws IOException {
	
		String testFile1 = "C:\\Users\\joseph_SonyV_i7-740q\\eclipseWorkspace\\FileSubStringComparisionProject\\src\\testGoldenFile.txt";
		String testFile2 = "testGoldenFile.txt";
		
		String resultOutput = new String("<SOME DATE CRAP HERE>>>434324-4532432.:343.45324.332432432.> <dlfjdslfjsdlk>WHAT?Testing123</dlfjdslfjsdlk>");
		 BufferedInputStream f = null;
		 String goldenOutString = null;
		 File newfp = new File(testFile2);
		String myPath = newfp.getAbsolutePath();
		
		System.out.printf("FIlepath2: %s\n", myPath);
		
		byte[] buffer= new byte[(int) new File(testFile1).length()];
		
	     try {
	    	 	
	    	     // System.out.printf("FilePath is: %s\n", newfp.getPath());
	             f = new BufferedInputStream(new FileInputStream(testFile1));   
	             f.read(buffer);
	             goldenOutString = new String(buffer);
	             System.out.printf("GOLDEN_FILESTRING2: %s \n\n", goldenOutString);
	             System.out.printf("RESULTSTRING:  %s\n", resultOutput);
	             
	           
	             int index = IndexOf(resultOutput.toCharArray(), goldenOutString.toCharArray());
	             System.out.println("\nIndex value now is: "+index);
	             System.out.println("\nLength of Golden is: "+ goldenOutString.length());
	
	         
	             if(index > 0 ) 
	             {
	            	 System.out.print("\nMATCHES!!!\n");
	            	 
	             }
	             else if(index <0) 
	             {
	            	 System.out.print("\nNO MATCHES!!!\n");
	             }
	           
	     } catch (IOException e) {
	             e.printStackTrace();
	           
	     }
	    finally {
	          f.close();
	     }
	}


			
	 /**
	  *        
	  * @param str
	  * @param substr
	  * @return
	  */
	 public static int IndexOf(char[] str, char[] substr)
	 {
	     boolean match;
	     
	     int LENGTH_OF_ERROR_POINT_TO_PROVIDE = 10;
	     char[] noMatchPoint= new char[LENGTH_OF_ERROR_POINT_TO_PROVIDE];  
	     int i=0, j=0;
	     int lastIPos=0, lastJPos=0;
	     
	     for (i = 0; i < str.length - substr.length + 1; ++i)
	     {
	    	 if (i>0) lastIPos=i;
	         match = true;
	         for (j = 0; j < substr.length; ++j)
	         {
	        	 if(j>0) lastJPos=j;
	             if (str[i + j] != substr[j])
	             {
	                 match = false;
	               
	                 break;
	             }
	         }
	         if (match)
	        	 return i;
	        
	     }
	
	     System.out.println("str len = "+str.length);
	     System.out.println("substr len = "+substr.length);
	     System.out.println("Indexed Value = "+i);
	     System.out.println("Last String Index = "+lastIPos);
	     System.out.println("Last Substring Index = "+lastJPos);
	     
	     int k;
	     if(i == str.length - substr.length + 1)  //meaning there was a mismatch somewhere in between
	     {
	    	 
	         for (k=0; k<LENGTH_OF_ERROR_POINT_TO_PROVIDE; k++)
	         {
	        	 noMatchPoint[k] = str[i++];  //Return back the next 5 or so characters from the point of mismatch to help debug
	         }
	        
	        
	        
	         System.out.printf("!!!DEBUGGING!!!: ASSISTED WORD TO HELP LOCATE MISMATCH IN OUTPUT IS: \"%s\"\n ", String.valueOf(noMatchPoint));
	         //System.out.printf("!!!DEBUGGING!!!: ASSISTED WORD TO HELP LOCATE MISMATCH IN OUTPUT IS: \"%s\"\n", String.valueOf(noMatchPoint));
	     }
	     return -1;
	 }
	     
	 /**
	  * 
	  * @param fileName
	  * @return
	  * @throws Exception
	  */
	 public static String getAbsolutePathToFile(String fileName) throws Exception
		{
			
			String fullPath=null;
			try {
				File newfp = new File(fileName);
				fullPath = newfp.getAbsolutePath();
				
				//from vidia
	            String pathWithoutFileName = fullPath.substring(0, fullPath.length()-fileName.length());
	            MyJavaUtilitiesClass o = new MyJavaUtilitiesClass(); 
	            String packageName = o.getClass().getPackage().getName(); 
	            packageName = packageName.replace(".", "\\");            
	            fullPath = pathWithoutFileName + "src\\" + packageName + "\\" +fileName;

			}
			catch (Exception e)
			{ e.printStackTrace(); }
			
			return fullPath;

		}
}

Input:


//Access Control
private  //has scope of package

//Default access will be accessible only from the classes inside package in which it is defined. Any method in any class which is defined in same package can access given variable in any way.(Via Inheritance or Direct access)

//Public means given variable will be accessible from all the class available in Java world. Any method in any class can access given variable in any way.(Via Inheritance or Direct access)

//Protected means it will be accessible only from the sub classes(Inside / Outside package) (Via Inheritance Only).

//Protected respect class subclass relation while Default doesnít. This is the only difference between these 2 modifier(Protected & Default).

//Private means it will be accessible only from within class. No one can access the given variable from outside class(Not even subclass).
