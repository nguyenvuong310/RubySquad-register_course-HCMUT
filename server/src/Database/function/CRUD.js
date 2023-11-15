const getConnection = require("../../Database/pool");

let insertData = async (tableName, data) => {
  try {
    // Acquire a connection using the getConnection function
    const connection = await getConnection();

    // Extract column names from the first object in the data array
    const columns = Object.keys(data);
    console.log(columns);
    // Construct the SQL query to insert data into the table
    const sqlQuery = `INSERT INTO ${tableName} (${columns.join(
      ", "
    )}) VALUES (?)`;

    // Extract values from each object in the data array
    const values = columns.map((col) => data[col]);
    // Log the SQL query for debugging purposes
    console.log("SQL Query:", sqlQuery);
    console.log("Values to Insert:", values);

    // Execute the SQL query to insert data
    const result = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [values], (queryErr, results) => {
        if (queryErr) {
          console.error("Query Error:", queryErr);
          reject(queryErr);
        } else {
          console.log("Insert Results:", results);
          resolve(results);
        }
      });
    });

    // Release the connection back to the pool
    await connection.release();

    console.log("Data inserted successfully");
    return result;
  } catch (error) {
    console.error("Error during data insertion:", error);
    throw new Error("Error during data insertion:", error);
  }
};
let getdata = async (tableName) => {
  try {
    const connection = await getConnection();

    const sqlQuery = `SELECT * FROM ${tableName}`;

    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, function (err, result, fields) {
        if (err) {
          connection.release();
          reject(err);
        }

        console.log(result);
        resolve(result);
      });
    });

    connection.release();

    return results;
  } catch (error) {
    throw new Error("Error during data retrieval:", error);
  }
};

let deleteById = async (tableName, id) => {
  try {
    // Acquire a connection using the getConnection function
    const connection = await getConnection();

    // Construct the SQL query to delete data by ID
    const sqlQuery = `DELETE FROM ${tableName} WHERE id = ?`;

    // Execute the SQL query to delete data
    await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [id], (queryErr, results) => {
        if (queryErr) {
          console.error("Query Error:", queryErr);
          reject(queryErr);
        } else {
          console.log("Delete Results:", results);
          resolve(results);
        }
      });
    });

    // Release the connection back to the pool
    connection.release();

    console.log("Data deleted successfully");
  } catch (error) {
    console.error("Error during data deletion:", error);
    throw new Error("Error during data deletion:", error);
  }
};

let getUserByEmail = async (email) => {
  try {
    // Acquire a connection using the getConnection function
    const connection = await getConnection();

    const sqlQuery = `SELECT * FROM users WHERE email = ?`;

    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [email], function (err, result, fields) {
        if (err) {
          connection.release();
          reject(err);
        }

        // console.log(result);
        resolve(result);
      });
    });

    connection.release();

    return results;
  } catch (error) {
    throw new Error("Error during data retrieval:", error);
  }
};
module.exports = {
  insertData,
  getdata,
  deleteById,
  getUserByEmail,
};
