-- このファイルに回答を記述してください。
SELECT
    PF_CODE AS 都道府県コード
    , PF_NAME AS 都道府県名
    , MAX( 
        CASE SUB.RNK 
            WHEN 1 THEN NATION_NAME 
            ELSE NULL 
            END
    ) AS "1位 国名"
    , MAX(CASE SUB.RNK WHEN 1 THEN AMT ELSE 0 END) AS "1位 人数"
    , MAX( 
        CASE SUB.RNK 
            WHEN 2 THEN NATION_NAME 
            ELSE NULL 
            END
    ) AS "2位 国名"
    , MAX(CASE SUB.RNK WHEN 2 THEN AMT ELSE 0 END) AS "2位 人数"
    , MAX( 
        CASE SUB.RNK 
            WHEN 3 THEN NATION_NAME 
            ELSE NULL 
            END
    ) AS "3位 国名"
    , MAX(CASE SUB.RNK WHEN 3 THEN AMT ELSE 0 END) AS "3位 人数"
    , SUM(AMT) AS 合計人数 
FROM
    ( 
        SELECT
            F.PF_CODE AS PF_CODE
            , P.PF_NAME AS PF_NAME
            , N.NATION_NAME AS NATION_NAME
            , F.AMT AS AMT
            , RANK() OVER ( 
                PARTITION BY
                    F.PF_CODE 
                ORDER BY
                    AMT DESC
                    , F.NATION_CODE
            ) AS RNK 
        FROM
            FOREIGNER AS F 
            INNER JOIN NATIONALITY AS N 
                ON N.NATION_CODE = F.NATION_CODE 
            INNER JOIN PREFECTURE AS P 
                ON P.PF_CODE = F.PF_CODE 
        WHERE
            F.NATION_CODE != '113'
    ) AS SUB 
GROUP BY
    SUB.PF_CODE
    , SUB.PF_NAME 
ORDER BY
    合計人数 DESC
    , 都道府県コード ASC;

--- もしくはWITH AS句を用いても良い。

WITH RankedNations AS ( 
    SELECT
        f.PF_CODE
        , p.PF_NAME
        , n.NATION_NAME
        , f.AMT
        , ROW_NUMBER() OVER ( 
            PARTITION BY
                f.PF_CODE 
            ORDER BY
                f.AMT DESC
                , f.NATION_CODE
        ) AS rn 
    FROM
        FOREIGNER f 
        JOIN NATIONALITY n 
            ON f.NATION_CODE = n.NATION_CODE 
        JOIN PREFECTURE p 
            ON f.PF_CODE = p.PF_CODE 
    WHERE
        f.NATION_CODE != '113'
) 
, AggregatedData AS ( 
    SELECT
        PF_CODE
        , PF_NAME
        , MAX(CASE WHEN rn = 1 THEN NATION_NAME END) AS First_Nation
        , MAX(CASE WHEN rn = 1 THEN AMT END) AS First_Amount
        , MAX(CASE WHEN rn = 2 THEN NATION_NAME END) AS Second_Nation
        , MAX(CASE WHEN rn = 2 THEN AMT END) AS Second_Amount
        , MAX(CASE WHEN rn = 3 THEN NATION_NAME END) AS Third_Nation
        , MAX(CASE WHEN rn = 3 THEN AMT END) AS Third_Amount
        , SUM(AMT) AS Total_Amount 
    FROM
        RankedNations 
    GROUP BY
        PF_CODE
        , PF_NAME
) 
SELECT
    PF_CODE AS 都道府県コード
    , PF_NAME AS 都道府県名
    , First_Nation AS "1位 国名"
    , First_Amount AS "1位 人数"
    , Second_Nation AS "2位 国名"
    , Second_Amount AS "2位 人数"
    , Third_Nation AS "3位 国名"
    , Third_Amount AS "3位 人数"
    , Total_Amount AS 合計人数 
FROM
    AggregatedData 
ORDER BY
    Total_Amount DESC
    , PF_CODE;
