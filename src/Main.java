/**
 * Created by Ten-Seng on 10/14/2015.
 */
import mysqlfirst.MySQLAccess;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
//import java.util.regex.Pattern;


public class Main {

    public static void main(String [] args)
    {
        MySQLAccess access = new MySQLAccess();

        access.TryUpdateQuery("insert into Seasons value (2015)");
        access.TryUpdateQuery("insert into Seasons value (2014)");
        access.TryUpdateQuery("insert into Seasons value (2013)");
        access.TryUpdateQuery("insert into Seasons value (2012)");
        access.TryUpdateQuery("insert into Seasons value (2011)");
        access.TryUpdateQuery("insert into Seasons value (2014)");
        access.TryGetQuery("select distinct * from Seasons", "SeasonYear");
        access.TestingQuery();


        String[] years = {"2012", "2013", "2015"};

        for (String year: years) {
            Scanner scan;
            //1st
            try {
                scan = new Scanner(new File("NBA gamelog " + year + ".csv"));
                scan.nextLine();

            } catch (FileNotFoundException e) {
                System.out.println("Can't find file!  Please check the name and try again.");
                return;
            }
            String row, home, away;

            for (int i = 0; i < 500; i++) {
                row = scan.nextLine();

                String[] fields = row.split(",");
                //1st inserting players
                access.TryUpdateQuery("insert into Players values (" + fields[1] + ", " + fields[2] + ", NULL, NULL)");
                //1st inserting teams
                //access.TryUpdateQuery("insert into Teams values (" + fields[3] + ")");
            }

            //2nd
            try {
                scan = new Scanner(new File("NBA gamelog " + year + ".csv"));
                scan.nextLine();

            } catch (FileNotFoundException e) {
                System.out.println("Can't find file!  Please check the name and try again.");
                return;
            }
            for (int i = 0; i < 500; i++) {
                row = scan.nextLine();

                String[] fields = row.split(",");
                //2nd inserting belongsTo to get all the team names
                access.TryUpdateQuery("insert into BelongsTo values (" + fields[3] + ", " + year + ", " + fields[5] + ", " + fields[4] + ")");
            }

            //3rd
            try {
                scan = new Scanner(new File("NBA gamelog " + year + ".csv"));
                scan.nextLine();

            } catch (FileNotFoundException e) {
                System.out.println("Can't find file!  Please check the name and try again.");
                return;
            }
            for (int i = 0; i < 120; i++) {
                row = scan.nextLine();

                String[] fields = row.split(",");
                //3rd inserting Games
                if (fields[7].contains("vs")) {
                    home = fields[3];
                    away = access.TryGetQuery("select TID from BelongsTo where TeamAbbr = \'" + fields[7].substring(9, 12) + "\' and SeasonYear = " + year, "TID");
                } else {
                    home = access.TryGetQuery("select TID from BelongsTo where TeamAbbr = \'" + fields[7].substring(7, 10) + "\' and SeasonYear = " + year, "TID");
                    away = fields[3];
                }
                access.TryUpdateQuery("insert into Games values (" + fields[6] + ", NULL, " + home + ", " + away + ", " + year + ")");


                //3rd inserting IndPerf
                access.TryUpdateQuery("insert into IndPerf values (" + fields[6] + ", " + fields[1] + "," + fields[3] + ", " + fields[10] + ", " + fields[11] + ", " + fields[13] + ", " + fields[14] + ", " + fields[16] + ", " + fields[17] + ", " + fields[21] + ", " + fields[22] + ", " + fields[23] + ", " + fields[24] + ", " + fields[25] + ", " + fields[26] + ", " + fields[27] + ")");
            }

        }

    }
}
