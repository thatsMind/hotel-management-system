import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

import java.util.Calendar;
import java.util.Scanner;

public class Main {
    private static Connection connect = null;
    private static Statement statement = null;
    private static PreparedStatement preparedStatement = null;
    private static ResultSet resultSet = null;
    private static ResultSet alternateSet = null;
    private static String url = "jdbc:mysql://localhost/HotelManagementDB";
    private static String user = "root", pass = "password"; //default


    public static void main(String[] args) throws Exception{

        Scanner keyboard = new Scanner(System.in);
        boolean exit = true;
        String userInput;
        try {
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/", user, pass);
            System.out.println("Connection established......");
            ScriptRunner sr = new ScriptRunner(connect, false, true);
            System.out.println("Working Directory = " + System.getProperty("user.dir"));
            //InputStream in = Main.class.getResourceAsStream("dropdbmodel.sql");
            //BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(in));
            //sr.runScript(bufferedReader);
            //InputStream in2 = Main.class.getResourceAsStream("hotelmanagementdbmodel.sql");
            //BufferedReader bufferedReader2 = new BufferedReader(new InputStreamReader(in2));
            //sr.runScript(bufferedReader2);
            //InputStream in3 = Main.class.getResourceAsStream("inserts.sql");
            //BufferedReader bufferedReader3 = new BufferedReader(new InputStreamReader(in3));
            //sr.runScript(bufferedReader3);

            File dropFile = new File("./dropdbmodel.sql");
            File dbmodelFile = new File("./hotelmanagementdbmodel.sql");
            File insertFile = new File("./inserts.sql");

            Reader reader = new BufferedReader(new FileReader(dropFile));
            sr.runScript(reader);
            reader = new BufferedReader(new FileReader(dbmodelFile));
            sr.runScript(reader);
            reader = new BufferedReader(new FileReader(insertFile));
            sr.runScript(reader);


        } catch (SQLException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("\n===============================================");
        System.out.println("hotelmanagementdbmodel.sql successful executed.");
        System.out.println("inserts.sql successful executed.");
        System.out.println("===============================================\n\n");

        boolean unlocked = false;
        String currentUser = "None";
        String userName = "";
        boolean loggedIn = false;

        System.out.print("What's your mySQL user?\n\n > ");
        user =keyboard.nextLine();
        System.out.print("What's your mySQL password?\n\n > ");
        pass = keyboard.nextLine();


        while (exit) {
            boolean breakerino=false;
            System.out.println("-----------------------------------------------------");
            //System.out.println("-------------------(Start Session)-------------------");
            //System.out.println("--------------------(End Session)-------------------");

            System.out.println("Currently Login as : " + currentUser + " " + userName);

            System.out.println("> User Menu (input a digit from the provided options)\n> 1. Create Account\n> 2. Login\n> 3. Search\n> 4. Insert\n> 5. Update\n> 6. Delete\n> 7. Exit");
            System.out.print("\n> Select an option:  ");
            userInput = keyboard.nextLine();
            switch (userInput) {
                case "1":
                    boolean checkingInput = true;
                    while(checkingInput){
                        System.out.println("You selected Create Account");
                        System.out.println("Are you an employee(1) or customer(2) or go back to user Menu(3)?");
                        System.out.print("\n> Select an option:  ");
                        String userResponse = keyboard.nextLine();
                        if (userResponse.equals("1")) {
                            checkingInput=false;
                            try {
                                connect = DriverManager.getConnection(url, user, pass);
                                statement = connect.createStatement();
                                System.out.print("Employee Name: ");
                                String employeeName = keyboard.nextLine();
                                System.out.print("Email: ");
                                String employeeEmail = keyboard.nextLine();
                                System.out.print("SSN: ");
                                String ssn = keyboard.nextLine();
                                System.out.print("Password: ");
                                String epass = keyboard.nextLine();
                                //inserting employee data
                                preparedStatement = connect.prepareStatement("insert into employee (employee_id, email, ssn, name)" +
                                        " values (?, ?, ?, ?)");
                                //select all employee data
                                resultSet = statement.executeQuery("select * from employee");
                                int employeeIndex = 1;
                                //pre + index++
                                while (resultSet.next()) {
                                    employeeIndex = resultSet.getInt(1);
                                }
                                employeeIndex++;

                                preparedStatement.setInt(1, employeeIndex);
                                preparedStatement.setString(2, employeeEmail);
                                preparedStatement.setString(3, ssn);
                                preparedStatement.setString(4, employeeName);
                                preparedStatement.executeUpdate();

                                // Result set get the result of the SQL query
                                resultSet = statement.executeQuery("select * from account");
                                int accountIndex=0;
                                //index++ to insert new id positioning
                                while (resultSet.next()) {
                                    accountIndex = resultSet.getInt(1);
                                }
                                accountIndex++;

                                //System.out.println("index: " + accountIndex);

                                //get current date to insert
                                Calendar calendar = Calendar.getInstance();
                                java.sql.Date startDate = new java.sql.Date(calendar.getTime().getTime());
                                System.out.println(startDate);

                                //inserting account data
                                preparedStatement = connect.prepareStatement("insert into account (account_id, employee, type, password, created, guest)" +
                                        " values (?, ?, ?, ?, ?, ?)");
                                preparedStatement.setInt(1, accountIndex);
                                preparedStatement.setInt(2, employeeIndex);
                                preparedStatement.setInt(3, 1);
                                preparedStatement.setString(4, epass);
                                preparedStatement.setDate(5, startDate);
                                preparedStatement.setInt(6, 1);// must be 1 or higher?
                                preparedStatement.executeUpdate();

                                System.out.println("Employee account successfully created!");

                                connect.close();

                            } catch (SQLException e) {
                                e.printStackTrace();
                            } catch (Exception e) {
                                System.err.println("Got an exception!");
                                e.printStackTrace();
                            }

                        } else if (userResponse.equals("2")) {
                            checkingInput=false;
                            System.out.print("Customer Name: ");
                            String customerName = keyboard.nextLine();
                            System.out.print("Email: ");
                            String customerEmail = keyboard.nextLine();
                            System.out.print("Password: ");
                            String cpass = keyboard.nextLine();
                            String address = "";
                            String post_code = "";
                            String phone = "";
                            String city = "";
                            String state = "";
                            String country = "";

                            System.out.println("Would you like to fill out address details? yes(1) or no(2)");
                            System.out.print("\n> Select an option:  ");
                            String response = keyboard.nextLine();
                            if (response.equals("1")) {
                                System.out.print("Address: ");
                                address = keyboard.nextLine();
                                System.out.print("Post code: ");
                                post_code = keyboard.nextLine();
                                System.out.print("Phone: ");
                                phone = keyboard.nextLine();
                                System.out.print("City: ");
                                city = keyboard.nextLine();
                                System.out.print("State: ");
                                state = keyboard.nextLine();
                                System.out.print("Country: ");
                                country = keyboard.nextLine();
                            }
                            try {
                                // Setup the connection with the DB
                                connect = DriverManager.getConnection(url, user, pass);
                                // Statements allow to issue SQL queries to the database
                                statement = connect.createStatement();
                                // Result set get the result of the SQL query
                                resultSet = statement.executeQuery("select * from account");
                                int index = 1;
                                //index++ to insert new id positioning
                                while (resultSet.next()) {
                                    index = resultSet.getInt(1);
                                }
                                index++;
                                //System.out.println("index: " + index);
                                resultSet = statement.executeQuery("select * from guest");
                                int guestIndex = 1;
                                while (resultSet.next()) {
                                    guestIndex = resultSet.getInt(1);
                                }
                                guestIndex++;

                                preparedStatement = connect.prepareStatement("insert into guest (guest_id, name,email,address,post_code,phone,city,state,country)" +
                                        " values (?, ?, ?, ?,?,?,?,?,?)");

                                preparedStatement.setInt(1, guestIndex);
                                preparedStatement.setString(2, customerName);
                                preparedStatement.setString(3, customerEmail);
                                preparedStatement.setString(4, address);
                                preparedStatement.setString(5, post_code);
                                preparedStatement.setString(6, phone);
                                preparedStatement.setString(7, city);
                                preparedStatement.setString(8, state);
                                preparedStatement.setString(9, country);

                                preparedStatement.executeUpdate();

                                //get current date to insert
                                Calendar calendar = Calendar.getInstance();
                                java.sql.Date startDate = new java.sql.Date(calendar.getTime().getTime());
                                System.out.println(startDate);

                                //inserting account data
                                preparedStatement = connect.prepareStatement("insert into account (account_id, employee, type, password, created, guest)" +
                                        " values (?, ?, ?, ?, ?, ?)");
                                preparedStatement.setInt(1, index);
                                preparedStatement.setInt(2, 1);
                                preparedStatement.setInt(3, 1);
                                preparedStatement.setString(4, cpass);
                                preparedStatement.setDate(5, startDate);
                                preparedStatement.setInt(6, guestIndex);
                                preparedStatement.executeUpdate();


                                System.out.println("Customer account successfully created!");

                                connect.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } catch (Exception e) {
                                System.err.println("Got an exception!");
                                e.printStackTrace();
                            }
                        } else if(userResponse.equals("3")){
                            break;
                        }
                            else
                            System.out.println("Invalid input: " + userResponse);
                    }
                    break;
                case "2":
                    checkingInput= true;
                    if(loggedIn) {
                        System.out.println("You're already logged in!");
                        System.out.println("Do you want to log out? Yes(1) or No(2)");
                        String userChoice=keyboard.nextLine();
                        if(userChoice.equals("1")){
                            unlocked=false;
                            loggedIn=false;
                            currentUser = "none";
                            userName = "";
                            System.out.println("\nSuccessfully logged out!\n");
                        }else
                            break;
                        checkingInput=false;
                    }
                        while(checkingInput){
                        if(loggedIn){
                            break;
                        }
                        System.out.println("\nYou selected Login");
                        System.out.println("Login as employee(1) or customer(2) or go back to user menu(3)\n");
                            System.out.print("> Select an option:  ");
                            String userResponse=keyboard.nextLine();
                        if(userResponse.equals("1")){
                            System.out.println("Logging in as employee");
                            System.out.print("Email: ");
                            String email=keyboard.nextLine();
                            System.out.print("Password: ");
                            String epass=keyboard.nextLine();
                            try {
                                boolean emailMatchDatabase = false;
                                connect = DriverManager.getConnection(url, user, pass);
                                statement = connect.createStatement();
                                resultSet = statement.executeQuery("select * from employee");

                                while (resultSet.next()) {
                                    String emailCheck = resultSet.getString("email");
                                    String nameReplace = resultSet.getString("name");
                                    //testing all emails
                                    //System.out.println("\n------------------------------------");
                                    //System.out.println(email + " = " + emailCheck);
                                    if(emailCheck.equals(email)){
                                        //testing
                                       //System.out.println("\nemail is equal!\n");
                                        emailMatchDatabase=true;
                                        int employeeAccountRef=resultSet.getInt(1);
                                        alternateSet = statement.executeQuery("select * from account");
                                        while(alternateSet.next()){
                                            breakerino=true;
                                           int accountEmployeeRef= alternateSet.getInt("employee");
                                            String passCheck = alternateSet.getString("password");
//                                           //testing all pass
                                            //System.out.println(epass + " = " + passCheck);
                                            //testing reference employee id
                                            //System.out.println(employeeAccountRef + " = " + accountEmployeeRef);
                                            if(employeeAccountRef==accountEmployeeRef && epass.equals(passCheck)){
                                                //testing
                                                //System.out.println("\npass and ref is equal!");
                                                //System.out.println("------------------------------------\n");

                                                loggedIn=true;
                                                unlocked=true;
                                                currentUser = "Employee";
                                                userName = nameReplace;

                                                System.out.println();
                                                System.out.println("> You are logged as " + userName);
                                                System.out.println();
                                                break;
                                            }

                                        }
                                        if(breakerino){
                                            break;
                                        }
                                    }
                                }
                                if(!loggedIn){
                                    if(!emailMatchDatabase){
                                        System.out.println("Your Email doesn't exist in the system.");
                                    } else {
                                        System.out.println("Wrong password.");
                                    }
                                }
                                connect.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } catch (Exception e) {
                                System.err.println("Got an exception!");
                                e.printStackTrace();
                            }
                        }else if (userResponse.equals("2")){
                            System.out.println("Logging in as customer");
                            System.out.print("Email: ");
                            String email=keyboard.nextLine();
                            System.out.print("Password: ");
                            String cpass=keyboard.nextLine();
                            try {
                                boolean emailMatchDatabase = false;
                                // Setup the connection with the DB
                                connect = DriverManager.getConnection(url, user, pass);
                                // Statements allow to issue SQL queries to the database
                                statement = connect.createStatement();

                                resultSet = statement.executeQuery("select * from guest");

                                while (resultSet.next()) {
                                    String emailCheck = resultSet.getString("email");
                                    String nameReplace = resultSet.getString("name");
                                    //testing all emails
                                    //System.out.println("\n------------------------------------");
                                    //System.out.println(email + " = " + emailCheck);
                                    if(emailCheck.equals(email)){
                                        //testing
                                        //System.out.println("\nemail is equal!\n");
                                        emailMatchDatabase=true;
                                        int employeeAccountRef=resultSet.getInt(1);
                                        alternateSet = statement.executeQuery("select * from account");
                                        while(alternateSet.next()){
                                            breakerino=true;
                                            int accountAccountRef= alternateSet.getInt("guest");
                                            String passCheck = alternateSet.getString("password");
//                                           //testing all pass
                                            //System.out.println(cpass + " = " + passCheck);
                                            //testing reference guest id
                                            //System.out.println(employeeAccountRef + " = " + accountEmployeeRef);
                                            if(employeeAccountRef==accountAccountRef && cpass.equals(passCheck)){
                                                //testing
                                                loggedIn=true;
                                                //System.out.println("\npass and ref is equal!");
                                                //System.out.println("------------------------------------\n");

                                                currentUser = "Customer";
                                                userName = nameReplace;

                                                System.out.println();
                                                System.out.println("> You are logged as " + userName);
                                                System.out.println();
                                                break;
                                            }
                                        }
                                        if(breakerino){
                                            break;
                                        }
                                    }
                                }
                                if(!loggedIn){
                                    if(!emailMatchDatabase){
                                        System.out.println("Your Email doesn't exist in the system.");
                                    } else {
                                        System.out.println("Wrong password.");
                                    }
                                }
                                connect.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } catch (Exception e) {
                                System.err.println("Got an exception!");
                                e.printStackTrace();
                            }

                        }else if (userResponse.equals("3")){
                            break;
                        }else
                            System.out.println("Invalid input: " + userResponse);
                    }

                    break;
                case "3":
                    System.out.println("You selected Search");
                    if(unlocked) {
                        System.out.println(">Tables with write/read permissions for Employee " + userName);
                        System.out.println("> 1. Restaurant");
                        System.out.println("> 2. Hair Saloon");
                        System.out.println("> 3. Lounge");

                        System.out.print("Select a table to search: ");
                        String userResponse = keyboard.nextLine();
                        switch (userResponse) {
                            case "1": //NearBy Restaurant
                                int rating = 6;
                                boolean found = false;
                                while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                    System.out.print("Enter Rating(1-5): ");
                                    rating = keyboard.nextInt();
                                }
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from restaurant");
                                    System.out.println("Results:");

                                    while (resultSet.next()) {
                                        int rating2 = resultSet.getInt(3);
                                        String description = resultSet.getString(2);
                                        if (rating == rating2) {
                                            found = true;
                                            System.out.println(
                                                    "Rating: \t" + rating2 + "\n" +
                                                            "Restaurant Name: \t " + description);
                                            System.out.println();
                                        }
                                    }
                                    if (!found) {
                                        System.out.println("Does not exist.");
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                keyboard.nextLine();
                                break;
                            case "2": //hair saloon
                                rating = 6;
                                found = false;
                                while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                    System.out.print("Enter Rating(1-5): ");
                                    rating = keyboard.nextInt();
                                }
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from hairSaloon");
                                    System.out.println("Results:");

                                    while (resultSet.next()) {
                                        int rating2 = resultSet.getInt(3);
                                        String description = resultSet.getString(2);
                                        if (rating == rating2) {
                                            found = true;
                                            System.out.println(
                                                    "Rating: \t" + rating2 + "\n" +
                                                            "Hair Saloon Name: \t " + description);
                                            System.out.println();
                                        }
                                    }
                                    if (!found) {
                                        System.out.println("Does not exist.");
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                keyboard.nextLine();
                                break;
                            case "3": // lounge
                                rating = 6;
                                found = false;
                                while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                    System.out.print("Enter Rating(1-5): ");
                                    rating = keyboard.nextInt();
                                }
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from lounge");
                                    System.out.println("Results:");

                                    while (resultSet.next()) {
                                        int rating2 = resultSet.getInt(3);
                                        String description = resultSet.getString(2);
                                        if (rating == rating2) {
                                            found = true;
                                            System.out.println(
                                                    "Rating: \t" + rating2 + "\n" +
                                                            "Lounge Name: \t " + description);
                                            System.out.println();
                                        }
                                    }
                                    if (!found) {
                                        System.out.println("Does not exist.");
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                keyboard.nextLine();
                                break;
                            default:
                                break;
                        }
                    }
                    else if(loggedIn){
                        System.out.println(">Tables with write/read permissions for Customer " + userName);
                        System.out.println("> 1. Feedback");
                        System.out.println("> 2. Credit Card");
                        System.out.println("> 3. Bank Account");


                        System.out.print("Select a table to search: ");
                        String userResponse = keyboard.nextLine();
                        switch (userResponse) {
                            case "1": //feedback
                                int rating = 6;
                                boolean found = false;
                                while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                    System.out.print("Enter Rating(1-5): ");
                                    rating = keyboard.nextInt();
                                }
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from feedback");
                                    System.out.println("Results:");

                                    while (resultSet.next()) {
                                        int rating2 = resultSet.getInt(3);
                                        String description = resultSet.getString(2);
                                        if (rating == rating2) {
                                            found = true;
                                            System.out.println(
                                                    "Rating: \t" + rating2 + "\n" +
                                                            "Description: \t " + description);
                                            System.out.println();
                                        }
                                    }
                                    if (!found) {
                                        System.out.println("Does not exist.");
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                keyboard.nextLine();
                                break;
                            case "2": //credit card
                                found = false;
                                System.out.print("Enter credit Card number: ");
                                String creditCard = keyboard.nextLine();
                                System.out.print("Enter cvv: ");
                                String cvv = keyboard.nextLine();
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from creditCard");
                                    System.out.println("Results:");

                                    while (resultSet.next()) {
                                        String creditCardCompare = resultSet.getString(2);
                                        String bankName = resultSet.getString(3);
                                        String expDate = resultSet.getString(4);
                                        String cvvCompare = resultSet.getString(5);
                                        //System.out.println("creditCardCompare: " + creditCardCompare);
                                        //        System.out.println("cvvCompare: "+ cvvCompare);
                                        if (creditCard.equals(creditCardCompare) && cvv.equals(cvvCompare)) {
                                            found = true;
                                            System.out.println(
                                                    "Card Number: \t" + creditCardCompare + "\n" +
                                                            "Bank Name: \t " + bankName + "\n" +
                                                            "Expiration Date: \t" + expDate + "\n" +
                                                            "Cvv: \t" + cvvCompare);
                                            System.out.println();
                                        }
                                    }
                                    if (!found) {
                                        System.out.println("Does not exist.");
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "3": // bank account
                                found = false;
                                System.out.print("Enter Account Number: ");
                                String accountNum = keyboard.nextLine();
                                System.out.print("Enter routing Num: ");
                                String routingNum = keyboard.nextLine();
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from bankAccount");
                                    System.out.println("Results:");

                                    while (resultSet.next()) {
                                        String accountNumCompare = resultSet.getString(2);
                                        String bankName = resultSet.getString(3);
                                        String routingNumCompare = resultSet.getString(4);
                                        //System.out.println("creditCardCompare: " + creditCardCompare);
                                        //        System.out.println("cvvCompare: "+ cvvCompare);
                                        if (accountNum.equals(accountNumCompare) && routingNum.equals(routingNumCompare)) {
                                            found = true;
                                            System.out.println(
                                                    "Account Number: \t" + accountNumCompare + "\n" +
                                                            "Bank Name: \t " + bankName + "\n" +
                                                            "Routing Number: \t" + routingNumCompare);
                                            System.out.println();
                                        }
                                    }
                                    if (!found) {
                                        System.out.println("Does not exist.");
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            default:
                                break;
                        }
                    }
                    else{
                        System.out.println("You must login to access this feature!");
                    }

                    break;
                case "4":
                    if(unlocked) {
                        System.out.println("You selected Insert");
                        System.out.println(">Tables with write/read permissions for Employee " + userName);
                        System.out.println("> 1. Restaurant");
                        System.out.println("> 2. Hair Saloon");
                        System.out.println("> 3. Lounge");

                        System.out.print("Select a table to insert data: ");
                        String userResponse = keyboard.nextLine();
                        switch (userResponse) {
                            case "1":
                                int rating = 6;
                                while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                    System.out.print("Enter Rating(1-5): ");
                                    rating = keyboard.nextInt();
                                }
                                keyboard.nextLine();
                                System.out.print("Enter the Restaurant Name: ");
                                String restaurantName = keyboard.nextLine();
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from restaurant");
                                    System.out.println("Results:");

                                    int index = 1;
                                    while (resultSet.next()) {
                                        index = resultSet.getInt(1);
                                    }
                                    index++;
                                    preparedStatement = connect.prepareStatement("insert into restaurant (restaurant_id, restaurantName, rating)" +
                                            " values (?, ?, ?)");
                                    preparedStatement.setInt(1, index);
                                    preparedStatement.setString(2, restaurantName);
                                    preparedStatement.setInt(3, rating);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Restaurant uploaded!");

                                    connect.close();

                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "2":
                                rating = 6;
                                while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                    System.out.print("Enter Rating(1-5): ");
                                    rating = keyboard.nextInt();
                                }
                                keyboard.nextLine();
                                System.out.print("Enter the Hair Saloon Name: ");
                                String hairSaloonName = keyboard.nextLine();
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from hairSaloon");
                                    System.out.println("Results:");

                                    int index = 1;
                                    while (resultSet.next()) {
                                        index = resultSet.getInt(1);
                                    }
                                    index++;
                                    preparedStatement = connect.prepareStatement("insert into hairSaloon (hairSaloon_id, hairSaloonName, rating)" +
                                            " values (?, ?, ?)");
                                    preparedStatement.setInt(1, index);
                                    preparedStatement.setString(2, hairSaloonName);
                                    preparedStatement.setInt(3, rating);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Hair Saloon uploaded!");

                                    connect.close();

                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "3":
                                rating = 6;
                                while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                    System.out.print("Enter Rating(1-5): ");
                                    rating = keyboard.nextInt();
                                }
                                keyboard.nextLine();
                                System.out.print("Enter the Lounge Name: ");
                                String loungeName = keyboard.nextLine();
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from lounge");
                                    System.out.println("Results:");

                                    int index = 1;
                                    while (resultSet.next()) {
                                        index = resultSet.getInt(1);
                                    }
                                    index++;
                                    preparedStatement = connect.prepareStatement("insert into lounge (lounge_id, loungeName, rating)" +
                                            " values (?, ?, ?)");
                                    preparedStatement.setInt(1, index);
                                    preparedStatement.setString(2, loungeName);
                                    preparedStatement.setInt(3, rating);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Lounge uploaded!");

                                    connect.close();

                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                        }
                    }
                    else if(loggedIn) {
                        System.out.println("You selected Insert");
                        System.out.println(">Tables with write/read permissions for Customer " + userName);
                        System.out.println("> 1. Feedback");
                        System.out.println("> 2. Credit Card");
                        System.out.println("> 3. Bank Account");

                        System.out.print("Select a table to insert data: ");
                        String userResponse = keyboard.nextLine();
                        switch (userResponse) {
                            case "1": //feedback
                                int rating = 6;
                                while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                    System.out.print("Enter Rating(1-5): ");
                                    rating = keyboard.nextInt();
                                }
                                keyboard.nextLine();
                                System.out.print("Enter a description: ");
                                String description = keyboard.nextLine();
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from feedback");
                                    System.out.println("Results:");

                                    int index = 1;
                                    while (resultSet.next()) {
                                        index = resultSet.getInt(1);
                                    }
                                    index++;
                                    //inserting account data
                                    preparedStatement = connect.prepareStatement("insert into feedback (feedback_id, description, rating)" +
                                            " values (?, ?, ?)");
                                    preparedStatement.setInt(1, index);
                                    preparedStatement.setString(2, description);
                                    preparedStatement.setInt(3, rating);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Feedback uploaded!");

                                    connect.close();

                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "2": // credit card
                                System.out.print("Enter credit Card number: ");
                                String creditCard = keyboard.nextLine();
                                System.out.print("Enter bank Name: ");
                                String bankName = keyboard.nextLine();
                                System.out.print("Enter expiration date(\"YYYY-MM-DD\"): ");
                                String date = keyboard.nextLine();
                                java.util.Date expDate = new SimpleDateFormat("yyyy-MM-dd").parse(date);

                                System.out.print("Enter cvv(3 numbers only): ");
                                String cvv = keyboard.nextLine();
                                //keyboard.nextLine();
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from paymentType");
                                    System.out.println("Results:");

                                    int index = 1;
                                    while (resultSet.next()) {
                                        index = resultSet.getInt(1);
                                    }
                                    index++;
                                    preparedStatement = connect.prepareStatement("insert into paymentType (paymentType_id, address, zip_code, country, state, city)" +
                                            " values (?, ?, ?, ?, ?, ?)");
                                    preparedStatement.setInt(1, index);
                                    preparedStatement.setString(2, "");
                                    preparedStatement.setString(3, "");
                                    preparedStatement.setString(4, "");
                                    preparedStatement.setString(5, "");
                                    preparedStatement.setString(6, "");
                                    preparedStatement.executeUpdate();
                                    System.out.println(index);
                                    preparedStatement = connect.prepareStatement("insert into creditCard(payment_type,card_number,bank,exp_date,cvv)" +
                                            " values (?, ?, ?, ?, ?)");
                                    preparedStatement.setInt(1, index);
                                    preparedStatement.setString(2, creditCard);
                                    preparedStatement.setString(3, bankName);
                                    java.sql.Date sqlDate = new java.sql.Date(expDate.getTime());
                                    preparedStatement.setDate(4, sqlDate);
                                    preparedStatement.setString(5, cvv);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Added credit card!");

                                    connect.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "3": //bank account
                                System.out.print("Enter Account number: ");
                                String accountNum = keyboard.nextLine();
                                System.out.print("Enter Bank Name: ");
                                String bank_name = keyboard.nextLine();
                                System.out.print("Enter Routing Number: ");
                                String routingNum = keyboard.nextLine();
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from paymentType");
                                    System.out.println("Results:");

                                    int index = 1;
                                    while (resultSet.next()) {
                                        index = resultSet.getInt(1);
                                    }
                                    index++;
                                    preparedStatement = connect.prepareStatement("insert into paymentType(paymentType_id,address,zip_code,country,state,city )" +
                                            " values (?, ?, ?,?,?,?)");
                                    preparedStatement.setInt(1, index);
                                    preparedStatement.setString(2, "");
                                    preparedStatement.setString(3, "");
                                    preparedStatement.setString(4, "");
                                    preparedStatement.setString(5, "");
                                    preparedStatement.setString(6, "");
                                    preparedStatement.executeUpdate();
                                    preparedStatement = connect.prepareStatement("insert into bankAccount(payment_type, acc_number, bank, routing )" +
                                            " values (?, ?, ?,?)");
                                    preparedStatement.setInt(1, index);
                                    preparedStatement.setString(2, accountNum);
                                    preparedStatement.setString(3, bank_name);
                                    preparedStatement.setString(4, routingNum);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Added Bank Account!");

                                    connect.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            default:
                                break;
                        }
                    }
                    else{
                        System.out.println("You must login to access this feature!");
                    }
                    break;
                case "5":
                    if(unlocked){
                        System.out.println("You selected Update");
                        System.out.println(">Tables with write/read permissions for Employee " + userName);
                        System.out.println("> 1. Restaurant");
                        System.out.println("> 2. Hair Saloon");
                        System.out.println("> 3. Lounge");

                        System.out.print("Select a table to update data: ");
                        String userResponse = keyboard.nextLine();
                        switch(userResponse) {
                            case "1":
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from restaurant");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String name = resultSet.getString(2);
                                        int rating = resultSet.getInt(3);
                                        System.out.println("> " + id + ". " + name + " " + rating);
                                    }
                                    System.out.println("Enter the restaurant id you would like to update: ");
                                    int ratingId = keyboard.nextInt();
                                    keyboard.nextLine();
                                    int rating = 6;
                                    while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                        System.out.print("Enter a new Rating(1-5): ");
                                        rating = keyboard.nextInt();
                                    }
                                    keyboard.nextLine();
                                    System.out.print("Enter a new Restaurant Name: ");
                                    String restaurantName = keyboard.nextLine();

                                    preparedStatement = connect.prepareStatement("UPDATE restaurant SET restaurantName = ? , rating = ? WHERE restaurant_id = ?");
                                    preparedStatement.setString(1, restaurantName);
                                    preparedStatement.setInt(2, rating);
                                    preparedStatement.setInt(3, ratingId);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Restaurant updated!");

                                    connect.close();

                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "2":
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from hairSaloon");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String name = resultSet.getString(2);
                                        int rating = resultSet.getInt(3);
                                        System.out.println("> " + id + ". " + name + " " + rating);
                                    }
                                    System.out.println("Enter the hairSaloon id you would like to update: ");
                                    int ratingId = keyboard.nextInt();
                                    keyboard.nextLine();
                                    int rating = 6;
                                    while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                        System.out.print("Enter a new Rating(1-5): ");
                                        rating = keyboard.nextInt();
                                    }
                                    keyboard.nextLine();
                                    System.out.print("Enter a new Hair Saloon Name: ");
                                    String hairSaloonName = keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("UPDATE hairSaloon SET hairSaloonName = ? , rating = ? WHERE hairSaloon_id = ?");
                                    preparedStatement.setString(1, hairSaloonName);
                                    preparedStatement.setInt(2, rating);
                                    preparedStatement.setInt(3, ratingId);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Hair Saloon updated!");

                                    connect.close();

                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "3":

                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from lounge");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String name = resultSet.getString(2);
                                        int rating = resultSet.getInt(3);
                                        System.out.println("> " + id + ". " + name + " " + rating);
                                    }
                                    System.out.println("Enter the lounge id you would like to update: ");
                                    int ratingId = keyboard.nextInt();
                                    keyboard.nextLine();
                                    int rating = 6;
                                    while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                        System.out.print("Enter a new Rating(1-5): ");
                                        rating = keyboard.nextInt();
                                    }
                                    keyboard.nextLine();
                                    System.out.print("Enter a new Lounge Name: ");
                                    String LoungeName = keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("UPDATE Lounge SET LoungeName = ? , rating = ? WHERE Lounge_id = ?");
                                    preparedStatement.setString(1, LoungeName);
                                    preparedStatement.setInt(2, rating);
                                    preparedStatement.setInt(3, ratingId);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Lounge updated!");

                                    connect.close();

                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                        }

                    }
                    else if(loggedIn){
                        System.out.println("You selected Update");
                        System.out.println(">Tables with write/read permissions for Customer " + userName);
                        System.out.println("> 1. Feedback");
                        System.out.println("> 2. Credit Card");
                        System.out.println("> 3. Bank Account");

                        System.out.print("Select a table to update data: ");
                        String userResponse = keyboard.nextLine();
                        switch (userResponse) {
                            case "1": //feedback

                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from feedback");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String description = resultSet.getString(2);
                                        int rating = resultSet.getInt(3);
                                        System.out.println("> " + id + ". " + description + " " + rating);
                                    }
                                    System.out.println("Enter the feedback id you would like to update: ");
                                    int ratingId = keyboard.nextInt();
                                    keyboard.nextLine();
                                    int rating = 6;
                                    while (rating != 0 && rating != 1 && rating != 2 && rating != 3 && rating != 4 && rating != 5) {
                                        System.out.print("Enter a new Rating(1-5): ");
                                        rating = keyboard.nextInt();
                                    }
                                    keyboard.nextLine();
                                    System.out.print("Enter a new description: ");
                                    String description = keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("UPDATE feedback SET description = ? , rating = ? WHERE feedback_id = ?");
                                    preparedStatement.setString(1, description);
                                    preparedStatement.setInt(2, rating);
                                    preparedStatement.setInt(3, ratingId);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Feedback updated!");

                                    connect.close();

                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "2": // credit card

                                //keyboard.nextLine();
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from creditCard");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String cardNum = resultSet.getString(2);
                                        String bank = resultSet.getString(3);
                                        Date date=resultSet.getDate(4);
                                        String cvv=resultSet.getString(5);
                                        System.out.println("> " + id + ". " + cardNum + " " + bank+ " " + date+ " " + cvv);
                                    }
                                    System.out.print("Enter credit_Card id to update: ");
                                    int credit_cardID = keyboard.nextInt();
                                    keyboard.nextLine();
                                    System.out.print("Enter credit Card number to update: ");
                                    String creditCard = keyboard.nextLine();
                                    System.out.print("Enter bank Name to update: ");
                                    String bankName = keyboard.nextLine();
                                    System.out.print("Enter expiration date(\"YYYY-MM-DD\") to update: ");
                                    String date = keyboard.nextLine();
                                    java.util.Date expDate = new SimpleDateFormat("yyyy-MM-dd").parse(date);
                                    System.out.print("Enter cvv(3 numbers only) to update: ");
                                    String cvv = keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("UPDATE creditCard SET card_number = ? , bank = ?, exp_date = ?, cvv = ? WHERE payment_type = ?");
                                    preparedStatement.setString(1, creditCard);
                                    preparedStatement.setString(2, bankName);
                                    java.sql.Date sqlDate = new java.sql.Date(expDate.getTime());
                                    preparedStatement.setDate(3, sqlDate);
                                    preparedStatement.setString(4, cvv);
                                    preparedStatement.setInt(5, credit_cardID);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Updated credit card!");

                                    connect.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "3": //bank account

                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from bankAccount");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String accNum = resultSet.getString(2);
                                        String bank = resultSet.getString(3);
                                        String routing =resultSet.getString(4);
                                        System.out.println("> " + id + ". " + accNum + " " + bank+ " " + routing);
                                    }
                                    System.out.println("Enter bank Account id to update: ");
                                    int bankId = keyboard.nextInt();
                                    keyboard.nextLine();
                                    System.out.print("Enter Account number to update: ");
                                    String accountNum = keyboard.nextLine();
                                    System.out.print("Enter Bank Name to update: ");
                                    String bank_name = keyboard.nextLine();
                                    System.out.print("Enter Routing Number to update: ");
                                    String routingNum = keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("UPDATE bankAccount SET acc_number = ? , bank = ?, routing = ? WHERE payment_type = ?");
                                    preparedStatement.setInt(4, bankId);
                                    preparedStatement.setString(1, accountNum);
                                    preparedStatement.setString(2, bank_name);
                                    preparedStatement.setString(3, routingNum);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Updated Bank Account!");

                                    connect.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            default:
                                break;
                        }
                        //break;
                    }
                    else{
                        System.out.println("You must login to access this feature!");
                    }
                    break;
                case "6":
                    if(unlocked){
                        System.out.println("You selected Delete");
                        System.out.println(">Tables with write/read permissions for Employee " + userName);
                        System.out.println("> 1. Restaurant");
                        System.out.println("> 2. Hair Saloon");
                        System.out.println("> 3. Lounge");

                        System.out.print("Select a table to delete data: ");
                        String userResponse = keyboard.nextLine();
                        switch(userResponse) {
                            case "1":
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from restaurant");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String name = resultSet.getString(2);
                                        int rating = resultSet.getInt(3);
                                        System.out.println("> " + id + ". " + name + " " + rating);
                                    }
                                    System.out.println("Enter the restaurant id you would like to delete: ");
                                    int ratingId = keyboard.nextInt();
                                    keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("DELETE FROM restaurant WHERE restaurant_id = ?");
                                    preparedStatement.setInt(1, ratingId);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Deleted Restaurant!");

                                    connect.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "2":


                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from hairSaloon");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String name = resultSet.getString(2);
                                        int rating = resultSet.getInt(3);
                                        System.out.println("> " + id + ". " + name + " " + rating);
                                    }
                                    System.out.println("Enter the hairSaloon id you would like to delete: ");
                                    int ratingId = keyboard.nextInt();
                                    keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("DELETE FROM hairSaloon WHERE hairSaloon_id = ?");
                                    preparedStatement.setInt(1, ratingId);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Deleted Hair Saloon!");

                                    connect.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "3":


                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from lounge");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String name = resultSet.getString(2);
                                        int rating = resultSet.getInt(3);
                                        System.out.println("> " + id + ". " + name + " " + rating);
                                    }
                                    System.out.println("Enter the lounge id you would like to delete: ");
                                    int ratingId = keyboard.nextInt();
                                    keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("DELETE FROM lounge WHERE lounge_id = ?");
                                    preparedStatement.setInt(1, ratingId);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Deleted Lounge!");

                                    connect.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                        }

                    }
                    else if(loggedIn){
                        System.out.println("You selected Delete");
                        System.out.println(">Tables with write/read permissions for Customer " + userName);
                        System.out.println("> 1. Feedback");
                        System.out.println("> 2. Credit Card");
                        System.out.println("> 3. Bank Account");

                        System.out.print("Select a table to delete data: ");
                        String userResponse = keyboard.nextLine();
                        switch (userResponse) {
                            case "1": //feedback
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from feedback");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String description = resultSet.getString(2);
                                        int rating = resultSet.getInt(3);
                                        System.out.println("> " + id + ". " + description + " " + rating);
                                    }
                                    System.out.println("Enter the feedback id you would like to delete: ");
                                    int ratingId = keyboard.nextInt();
                                    keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("DELETE FROM feedback WHERE feedback_id = ?");
                                    preparedStatement.setInt(1, ratingId);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Deleted feedback!");

                                    connect.close();


                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "2": // credit card

                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from creditCard");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String cardNum = resultSet.getString(2);
                                        String bank = resultSet.getString(3);
                                        Date date=resultSet.getDate(4);
                                        String cvv=resultSet.getString(5);
                                        System.out.println("> " + id + ". " + cardNum + " " + bank+ " " + date+ " " + cvv);
                                    }
                                    System.out.print("Enter credit_Card id to delete: ");
                                    int credit_cardID = keyboard.nextInt();
                                    keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("DELETE FROM creditCard WHERE payment_type = ?");
                                    preparedStatement.setInt(1, credit_cardID);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Deleted credit card!");

                                    connect.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "3": //bank account

                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connect = DriverManager.getConnection(url, user, pass);
                                    statement = connect.createStatement();
                                    resultSet = statement.executeQuery("select * from bankAccount");
                                    while (resultSet.next()) {
                                        int id = resultSet.getInt(1);
                                        String accNum = resultSet.getString(2);
                                        String bank = resultSet.getString(3);
                                        String routing =resultSet.getString(4);
                                        System.out.println("> " + id + ". " + accNum + " " + bank+ " " + routing);
                                    }
                                    System.out.println("Enter bank Account id to delete: ");
                                    int bankId = keyboard.nextInt();
                                    keyboard.nextLine();
                                    preparedStatement = connect.prepareStatement("DELETE FROM bankAccount WHERE payment_type = ?");
                                    preparedStatement.setInt(1, bankId);
                                    preparedStatement.executeUpdate();

                                    System.out.println("Deleted Bank Account!");

                                    connect.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                break;
                            default:
                                break;
                        }
                        //break;
                    }
                    else{
                        System.out.println("You must login to access this feature!");
                    }
                    break;
                case "7":
                    System.out.println("You selected Exit");
                    exit = false;
                    break;
                default:
                    System.out.println("Your input is incorrect: " + userInput + "\n Please try again.");
                    break;
            }
        }
    }

}


