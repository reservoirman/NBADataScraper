/**
 * Created by Ten-Seng on 10/18/2015.
 */
/**
 * Created by Ten-Seng on 10/18/2015.
 */
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import mysqlfirst.MySQLAccess;


class PlayerClass
{
    public String dob;
    public String pos;
    public String name;
}

public class JSONParser {
    private ArrayList<String> nameList = new ArrayList<String>();
    private HashMap<String, PlayerClass> nameMap = new HashMap<String, PlayerClass>();
    private MySQLAccess access = new MySQLAccess();
    private void getGameDate(String player, String season)
    {
        String gameDate = "http://stats.nba.com/stats/playergamelog?LeagueID=00&PlayerID=" + player + "&Season=" + season + "&SeasonType=Regular+Season";

        //run this to get a
        try {
            // get an instance of the json parser from the json factory
            JsonFactory factory = new JsonFactory();
            JsonParser parser = factory.createParser(new URL(gameDate));
            JsonToken token = null;
            boolean letsGo = false;
            // continue parsing the token till the end of input is reached
            while(!parser.isClosed()) {
                token = parser.nextToken();
                if ("rowSet".equals(parser.getText())) {
                    letsGo = true;
                    break;
                }
            }
            if (letsGo) {
                while (!parser.isClosed()) {
                    if (token != null && JsonToken.START_ARRAY.equals(token)) {
                        parser.nextToken();
                        parser.nextToken();
                        token = parser.nextToken();
                        String gameid = parser.getText();
                        token = parser.nextToken();
                        String gamedate = parser.getText();

                        //insert
                        access.TryUpdateQuery("update Games set GameDate = IF(GameDate is NULL, STR_TO_DATE(\'" + gamedate + "\', \'%M %d, %Y\'), GameDate) where GameID = " + gameid);
                        System.out.println("Game " + gameid + " took place on " + gamedate);
                    } else token = parser.nextToken();
                }
            }


        }
        catch (Exception e)
        {
            System.out.println(e.toString());

        }
    }

    void getGameDates()
    {
        ArrayList<String> seasons = new ArrayList<String>();
        seasons.add("2010-11");
        seasons.add("2011-12");
        seasons.add("2012-13");
        seasons.add("2013-14");
        seasons.add("2014-15");
        for (String name: nameList)
        {
            for (String season: seasons)
            {
                getGameDate(name, season);
            }
        }
    }

    private void getBirthdayAndPosition(String player)
    {
        String bdayPos = "http://stats.nba.com/stats/commonplayerinfo?LeagueID=00&PlayerID="+ player + "&SeasonType=Regular+Season";

        try {
            // get an instance of the json parser from the json factory
            JsonFactory factory = new JsonFactory();
            JsonParser parser = factory.createParser(new URL(bdayPos));
            JsonToken token = null;
            boolean letsGo = false;
            // continue parsing the token till the end of input is reached
            while(!parser.isClosed()) {
                token = parser.nextToken();
                if ("rowSet".equals(parser.getText())) {
                    letsGo = true;
                    break;
                }
            }
            if (letsGo) {
                while (!parser.isClosed()) {
                    //
                    if (token != null && JsonToken.START_ARRAY.equals(token)) {
                        parser.nextToken();
                        parser.nextToken();
                        String playerID = parser.getText();
                        parser.nextToken();
                        parser.nextToken();
                        parser.nextToken();
                        String name = parser.getText();
                        parser.nextToken();
                        parser.nextToken();
                        parser.nextToken();
                        String birthDate = parser.getText().split("T")[0];

                        for (int i = 0; i < 8; i++) {
                            parser.nextToken();
                        }
                        String pos = parser.getText();
                        //insert
                        /*
                        access.TryUpdateQuery("insert into Players values (" + playerID + ", \'" + name + "\', STR_TO_DATE(\'" + birthDate + "\', \'%Y-%m-%D\'), \'"
                                + pos + "\') on duplicate key update PlayerName = \'" + name + "\', DOB = STR_TO_DATE('" + birthDate + "\', \'%Y-%m-%D\'), Position = \'"
                                + pos + "\'");
*/
                                System.out.println("Player: " + playerID + " Name: " + name + " BirthDate: " + birthDate + " Position: " + pos);
                        String query = String.format("update Players set DOB = STR_TO_DATE(\'%s\', \'%%Y-%%m-%%D\'), Position = \'%s\' where PID = %s and DOB is null and POSITION is null", birthDate, pos, playerID);
                        if (name.contains("Battie"))
                        {
                            int i = 0;
                        }
                        access.TryUpdateQuery(query);

                        break;
                    } else token = parser.nextToken();
                }
            }


        }
        catch (Exception e)
        {
            System.out.println(e.toString());

        }

    }

    void getBirthdaysAndPositions()
    {
        for (String name: nameList)
        {
            getBirthdayAndPosition(name);
        }
    }

    void getNames()
    {
        String playerList = "http://stats.nba.com/stats/commonallplayers?IsOnlyCurrentSeason=0&LeagueID=00&Season=2015-16";

        //run this to get a
        try {
            // get an instance of the json parser from the json factory
            JsonFactory factory = new JsonFactory();
            JsonParser parser = factory.createParser(new URL(playerList));
            JsonToken token = null;
            // continue parsing the token till the end of input is reached
            while (!parser.isClosed()) {
                if (token != null && JsonToken.START_ARRAY.equals(token)) {
                    token = parser.nextToken();
                    if (JsonToken.VALUE_NUMBER_INT.equals(token)) {
                        nameList.add(parser.getText());
                        System.out.println(parser.getText());
                    }

                }
                else token = parser.nextToken();
            }

        }
        catch (Exception e)
        {
            System.out.println(e.toString());

        }


    }


    public static void main(String[] args) throws MalformedURLException, IOException {
        // Get active players in the 2016 season:
        JSONParser holla = new JSONParser();
        holla.getBirthdaysAndPositions();
        //holla.getNames();
        //holla.getGameDates();
    }
}