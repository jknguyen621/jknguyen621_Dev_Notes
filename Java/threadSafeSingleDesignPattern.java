package com.journaldev.designpatterns;

public class ASingleton{

	private static ASingleton instance= null;
	private static Object mutex= new Object();
	private ASingleton(){
	}

	public static ASingleton getInstance(){
		if(instance==null){
			synchronized (mutex){
				if(instance==null) instance= new ASingleton();
			}
		}
		return instance;
	}

}


/*
In general we follow below steps to create a singleton class:

1. Override the private constructor to avoid any new object creation with new operator.
2. Declare a private static instance of the same class
3. Provide a public static method that will return the singleton class instance variable. 
   If the variable is not initialized then initialize it or else simply return the instance variable.

There are three ways through which we can achieve thread safety.

1. Create the instance variable at the time of class loading.
2. Synchronize the getInstance() method
3. Use synchronized block inside the if loop

*/
