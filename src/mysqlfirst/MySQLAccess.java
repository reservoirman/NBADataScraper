package mysqlfirst;

/**
 * Created by Ten-Seng on 10/14/2015.
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class MySQLAccess {
    private Connection connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public MySQLAccess()
    {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager.getConnection("jdbc:mysql://cs4111.cwdl9enlsy5w.us-west-2.rds.amazonaws.com:3306/cs4111", "tg2458", "tianguh6");

            System.out.println("Successfully connected to DB!");
        }
        catch (Exception e)
        {
            System.out.println("ERROR CONNECTING TO DATABASE!!! " + e.toString() + e.getMessage());
        }
    }



    public void TestingQuery()
    {
        try {
            statement = connect.createStatement();
            resultSet = statement.executeQuery("select * from Seasons");
            writeResultSet(resultSet);
        }
        catch (Exception e) {
            System.out.println("ERROR EXECUTING QUERY!! " + e.toString() + e.getMessage());
        }
    }

    public void TryUpdateQuery(String query)
    {
        System.out.println(query);
        try {
            statement = connect.createStatement();
            int result = statement.executeUpdate(query);
        }
        catch (Exception e) {
            System.out.println("ERROR EXECUTING QUERY!!\n" + e.toString() + '\n');
        }

    }

    public String TryGetQuery(String query, String field) {
        String result = null;
        try {
            statement = connect.createStatement();
            resultSet = statement.executeQuery(query);
            resultSet.next();
            result = resultSet.getString(field);
            System.out.println(result);
        }
        catch (Exception e) {
            System.out.println("ERROR EXECUTING QUERY!! " + e.toString() + e.getMessage());
        }
        return result;
    }

    private void writeResultSet(ResultSet resultSet) throws SQLException {
        // ResultSet is initially before the first data set
        while (resultSet.next()) {
            // It is possible to get the columns via name
            // also possible to get the columns via the column number
            // which starts at 1
            // e.g. resultSet.getSTring(2);
            String year = resultSet.getString("SeasonYear");
            System.out.println("Season Year: " + year);
        }
    }
    // You need to close the resultSet
    private void close() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }

            if (statement != null) {
                statement.close();
            }

            if (connect != null) {
                connect.close();
            }
        } catch (Exception e) {

        }
    }

}
