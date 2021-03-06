//Threads can be created mainly in 3 different ways

//1. Extend the java.lang.Thread class'

class SampleThread extends Thread {

    //method where the thread execution will start 
    public void run(){
        //logic to execute in a thread    
    }

    //let’s see how to start the threads
    public static void main(String[] args){
       Thread t1 = new SampleThread();
       Thread t2 = new SampleThread();
       t1.start();  //start the first thread. This calls the run() method.
       t2.start(); //this starts the 2nd thread. This calls the run() method.  
    }
} 


//2. Implement the java.lang.Runnable interface

class A implements Runnable{

    @Override
    public void run() {

        // implement run method here 
    }

    public static void main() {
        final A obj = new A();

        Thread t1 = new Thread(new A());

        t1.start();
    }


}


//3. Implement the java.util.concurrent.Callable interface

class Counter implements Callable {

    private static final int THREAD_POOL_SIZE = 2;

    // method where the thread execution takes place
    public String call() {
        return Thread.currentThread().getName() + " executing ...";
    }

    public static void main(String[] args) throws InterruptedException,
            ExecutionException {
        // create a pool of 2 threads
        ExecutorService executor = Executors
                .newFixedThreadPool(THREAD_POOL_SIZE);

        Future future1 = executor.submit(new Counter());
        Future future2 = executor.submit(new Counter());

        System.out.println(Thread.currentThread().getName() + " executing ...");

        //asynchronously get from the worker threads
        System.out.println(future1.get());
        System.out.println(future2.get());

    }
}

//Favor Callable interface with the Executor framework for thread pooling.

//The Runnable or Callable interface is preferred over extending the Thread class


