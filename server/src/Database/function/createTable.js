const getConnection = require("../../Database/pool");
const path = require("path");
const fs = require("fs").promises;

let createTable = async () => {
  try {
    const sqlFilePath = path.join(__dirname, "..", "sql", "createTable.sql");

    // Read the SQL file using fs.promises.readFile
    const fileContent = await fs.readFile(sqlFilePath, "utf8");

    // Split the content into commands
    const sqlCommands = fileContent.split(";");

    // Acquire a connection using the getConnection function
    const connection = await getConnection();

    // Execute all SQL commands concurrently
    const executeCommands = sqlCommands.map(async (sqlCommand) => {
      const trimmedCommand = sqlCommand.trim();
      if (trimmedCommand) {
        return new Promise((resolve, reject) => {
          connection.query(trimmedCommand, (queryErr, results) => {
            if (queryErr) {
              reject(queryErr);
            } else {
              resolve(results);
            }
          });
        });
      }
    });

    // Wait for all commands to complete
    await Promise.all(executeCommands);

    // Release the connection back to the pool
    connection.release();

    // console.log("create table successfully");
  } catch (error) {
    console.log("Error during SQL file import in createTable.js:", error);
    throw new Error("Error during SQL file import in createTable.js:", error);
  }
};

module.exports = createTable;
