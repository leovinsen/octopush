const MF_HISTORY = "mutual_funds_history";

const MF_HISTORY_ID = "id";
const MF_HISTORY_PRODUCT_ID = "product_id";
const MF_HISTORY_DATETIME = "datetime";
const MF_HISTORY_PURCHASE_INTERVAL = "purchase_interval";
const MF_HISTORY_AMOUNT = "amount";

///Product ID is foreign key, but temporarily the products are not inserted into Database
///Once products are inserted into Database we can make it a FK
const MF_HISTORY_CREATE_TABLE = """
  CREATE TABLE $MF_HISTORY (
    $MF_HISTORY_ID INTEGER PRIMARY KEY,
    $MF_HISTORY_PRODUCT_ID INTEGER NOT NULL,
    $MF_HISTORY_DATETIME TEXT NOT NULL,
    $MF_HISTORY_PURCHASE_INTERVAL INT NOT NULL,
    $MF_HISTORY_AMOUNT INTEGER NOT NULL
  )
""";