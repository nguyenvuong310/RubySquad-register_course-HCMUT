import createTable from "./function/createTable";
import insertData from "./function/insertData";
const initializeDatabase = async () => {
  try {
    await createTable();
    await insertData();
    console.log("init database succeed");
  } catch (error) {
    console.error("Error initializing database:", error);
  }
};
module.exports = initializeDatabase;
