/**
 * Created by Ten-Seng on 10/14/2015.
 */
import mysqlfirst.MySQLAccess;


public class Main {

    public static void main(String [] args)
    {
        MySQLAccess access = new MySQLAccess();

        access.TryUpdateQuery("insert into Seasons value (2014)");
        access.TryUpdateQuery("insert into Seasons value (2014)");
        access.TryGetQuery("select distinct * from Seasons");
        access.TestingQuery();

    }
}
