.pragma library
var db;
function gtDb() {
     db = openDatabaseSync("DriverDb", "1.0", "DriverDb", 100000);
    initialize();
}
function initialize() {
    db.transaction(
        function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS drive(drv TEXT, say INTEGER)");
      })
}
function drivese(cefdr,aatt) {
    if((cefdr == "E")&&(aatt==1)){
    db.transaction(
                    function(tx) {
            tx.executeSql("INSERT INTO drive (drv,say) VALUES(?,?)",["E",1]);
                }
                )
    }
    if((cefdr == "C")&&(aatt==0)){
    db.transaction(
                    function(tx) {
            tx.executeSql("INSERT INTO drive (drv,say) VALUES(?,?)",["C",0]);
                }
                )
    }
    if((cefdr == "F")&&(aatt==2)) {
        db.transaction(
                    function(tx) {
                        tx.executeSql("INSERT INTO drive (drv,say) VALUES(?,?)",["F",2]);
                    }
                    )
    }
}
function updateDrvSay(drv,say) {
    db.transaction(
                    function(tx) {
                        tx.executeSql("UPDATE drive SET drv = ?, say = ?",[drv,say]);
                }
                )
}
function frkd(kh) {
    db.readTransaction(
                    function(tx) {
                        var rs = tx.executeSql("SELECT say FROM drive WHERE say=?",kh)
                        if(rs.rows.length === 1) {
                            kh = rs.rows.item(0);
                        }
                }
                )
    return kh;
}
function drkd(tk) {
    db.readTransaction(
                    function(tx) {
                        var rs = tx.executeSql("SELECT drv FROM drive WHERE drv=?",tk)

                        if(rs.rows.length === 1) {
                            tk = rs.rows.item(0);
                        }
                }
                )
    return tk;
}
