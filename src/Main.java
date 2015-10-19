/**
 * Created by Ten-Seng on 10/14/2015.
 */
import mysqlfirst.MySQLAccess;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
//import java.util.regex.Pattern;


class Scraper extends Thread
{
    String year;

    public Scraper(String theYear)
    {
        year =theYear;
    }

    public void run()
    {
        System.out.println("Thread for scraping season " + year + " has begun working!");
        MySQLAccess access = new MySQLAccess();
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
/*
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
*/
        //3rd
        try {
            scan = new Scanner(new File("NBA gamelog " + year + ".csv"));
            scan.nextLine();

        } catch (FileNotFoundException e) {
            System.out.println("Can't find file!  Please check the name and try again.");
            return;
        }
        while(scan.hasNextLine()) {
            row = scan.nextLine();

            String[] fields = row.split(",");
            if (fields.length > 1) {
                try {
                    //1st inserting players
                    access.TryUpdateQuery("insert into Players values (" + fields[1] + ", " + fields[2] + ", NULL, NULL)");
                } catch (Exception e) {
                    System.out.println(e.toString());
                    System.out.println("The offending line: ");
                    for (String field : fields) {
                        System.out.print(field);
                    }

                }

                //3rd inserting Games

            try {
                String[] teams = fields[7].replace("\"","").split(" ");
                if (teams[1].contains("v")) {
                    home = fields[3];
                    away = access.TryGetQuery("select TID from BelongsTo where TeamAbbr = \'" + teams[2] + "\' and SeasonYear = " + year, "TID");
                } else {
                    home = access.TryGetQuery("select TID from BelongsTo where TeamAbbr = \'" + teams[2] + "\' and SeasonYear = " + year, "TID");
                    away = fields[3];
                }
                //System.out.println("matchup field is = " + fields[7]);
                access.TryUpdateQuery("insert into Games values (" + fields[6] + ", NULL, " + home + ", " + away + ", " + year + ")");
            }
            catch (Exception e)
            {
                System.out.println(e.toString());
                System.out.println("matchup field is = " + fields[7] + "!!!");
                return;
            }

            //3rd inserting IndPerf
            access.TryUpdateQuery("insert into IndPerf values (" + fields[6] + ", " + fields[1] + "," + fields[3] + ", " + fields[10] + ", " + fields[11] + ", " + fields[13] + ", " + fields[14] + ", " + fields[16] + ", " + fields[17] + ", " + fields[21] + ", " + fields[22] + ", " + fields[23] + ", " + fields[24] + ", " + fields[25] + ", " + fields[26] + ", " + fields[27] + ")");

            }
        }
    }


}

public class Main {

    public static void main(String [] args)
    {


        /*
        access.TryUpdateQuery("insert into Seasons value (2015)");
        access.TryUpdateQuery("insert into Seasons value (2014)");
        access.TryUpdateQuery("insert into Seasons value (2013)");
        access.TryUpdateQuery("insert into Seasons value (2012)");
        access.TryUpdateQuery("insert into Seasons value (2011)");
        access.TryUpdateQuery("insert into Seasons value (2014)");
        access.TryGetQuery("select distinct * from Seasons", "SeasonYear");
        access.TestingQuery();
        */

        String[] years = {"2013", "2014", "2012", "2015", "2011"};
        Scraper[] scrapers = new Scraper[5];

        /*
        int i = 0;
        for (String year: years) {
            scrapers[i] = new Scraper(year);
            scrapers[i].start();
            i++;
        }*/

        JSONParser holla = new JSONParser();
        holla.getNames();
        //holla.getGameDates();
        holla.getBirthdaysAndPositions();

    }
}
