const getConnection = require("../../Database/pool");
const path = require("path");

let checkInTable = async (tableName, id) => {
  try {
    let connection = await getConnection();
    const Query = `SELECT * FROM ${tableName} WHERE MS = ?`;

    const Results = await new Promise((resolve, reject) => {
      connection.query(Query, [id], (queryErr, results) => {
        if (queryErr) {
          console.error("Query Error:", queryErr);
          reject(queryErr);
        } else {
          resolve(results);
        }
      });
    });
    await connection.release();
    if (Results.length > 0) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    console.log("Error during SQL file import in checkExist.js");
    throw new Error("Error during SQL file import checkExist.js:", error);
  }
};

module.exports = checkInTable;
