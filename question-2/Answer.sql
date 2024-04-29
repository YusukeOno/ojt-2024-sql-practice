-- このファイルに回答を記述してください。
SELECT
    STD.AGE_CODE AS 年齢コード
    , AG.AGE_NAME AS 年齢階層名
    , SUM(STD.SP_TIME_5) AS "5時間未満"
    , SUM(STD.SP_TIME_6) AS "5時間以上6時間未満"
    , SUM(STD.SP_TIME_7) AS "6時間以上7時間未満"
    , SUM(STD.SP_TIME_8) AS "7時間以上8時間未満"
    , SUM(STD.SP_TIME_9) AS "8時間以上9時間未満"
    , SUM(STD.SP_TIME_9OVER) AS "9時間以上" 
FROM
    SLEEP_TIME_DTL AS STD 
    INNER JOIN AGE_GRP AS AG 
        ON AG.AGE_CODE = STD.AGE_CODE 
    INNER JOIN PREFECTURE AS PF 
        ON STD.PF_CODE = PF.PF_CODE 
WHERE
    PF.PF_NAME IN ('北海道', '青森県', '岩手県', '宮城県', '福島県') -- PF_CODEで絞り込んでも良い
GROUP BY
    STD.AGE_CODE
    , AG.AGE_NAME 
ORDER BY
    STD.AGE_CODE ASC;
