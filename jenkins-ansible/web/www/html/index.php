<!DOCTYPE html>
<html>
<head>
    <title>Table with database</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            color: #588c7e;
            font-family: monospace;
            font-size: 25px;
            text-align: left;
        }
        th {
            background-color: #588c7e;
            color: white;
        }
        tr:nth-child(even) {background-color: #f2f2f2}
    </style>
</head>
<body>
<table>
    <tr>
        <th>id</th>
        <th>name</th>
        <th>lastname</th>
        <th>age</th>
    </tr>
    <?php
    $conn = pg_connect("host=db_host dbname=people user=postgres password=admin");
    // Check connection
    if (!$conn) {
        die("Connection failed: " . pg_last_error());
    }

    $sql = "SELECT id, name, lastname, age FROM register  where age = 25 ";
    $result = pg_query($conn, $sql);

    if (pg_num_rows($result) > 0) {
        // output data of each row
        while($row = pg_fetch_assoc($result)) {
            echo "<tr><td>" . $row["id"]. "</td><td>" . $row["name"] . "</td><td>"
                . $row["lastname"]. "</td><td>" . $row["age"]. "</td></tr>";
        }
        echo "</table>";
    } else {
        echo "0 results";
    }
    pg_close($conn);
    ?>
</table>
</body>
</html>