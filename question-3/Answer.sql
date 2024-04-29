-- このファイルに回答を記述してください。
SELECT
    T1.港コード AS 港コード
    , T1.港名 AS 港名
    , T1.入国者数 AS 入国者数
    , T1.出国者数 AS 出国者数
    , T1.差分 AS 差分 
FROM
    ( 
        SELECT
            IM1.PORT_CODE AS 港コード
            , PT.PORT_NAME AS 港名
            , IM1.AMT AS 入国者数
            , IM2.AMT AS 出国者数
            , (IM1.AMT - IM2.AMT) AS 差分 
        FROM
            IMMIGRATION AS IM1 
            INNER JOIN PORT AS PT 
                ON PT.PORT_CODE = IM1.PORT_CODE 
                AND IM1.GROUP_CODE = '120'      -- 外国人のみ
                AND IM1.KIND_CODE = '110'       -- 入国者
            INNER JOIN IMMIGRATION AS IM2 
                ON IM2.PORT_CODE = IM1.PORT_CODE 
                AND IM2.GROUP_CODE = IM1.GROUP_CODE 
                AND IM2.KIND_CODE = '120'       -- 出国者
    ) AS T1 
WHERE
    T1.差分 > 0 
ORDER BY
    T1.差分 DESC
    , T1.港コード DESC;

-- もしくは元表における条件をWHERE句に出しても良い。

SELECT
    T1.港コード AS 港コード
    , T1.港名 AS 港名
    , T1.入国者数 AS 入国者数
    , T1.出国者数 AS 出国者数
    , T1.差分 AS 差分 
FROM
    ( 
        SELECT
            IM1.PORT_CODE AS 港コード
            , PT.PORT_NAME AS 港名
            , IM1.AMT AS 入国者数
            , IM2.AMT AS 出国者数
            , (IM1.AMT - IM2.AMT) AS 差分 
        FROM
            IMMIGRATION AS IM1 
            INNER JOIN PORT AS PT 
                ON PT.PORT_CODE = IM1.PORT_CODE 
            INNER JOIN IMMIGRATION AS IM2 
                ON IM2.PORT_CODE = IM1.PORT_CODE 
                AND IM2.GROUP_CODE = IM1.GROUP_CODE 
                AND IM2.KIND_CODE = '120'       -- 出国者
        WHERE
            IM1.GROUP_CODE = '120'              -- 外国人のみ
            AND IM1.KIND_CODE = '110'           -- 入国者
    ) AS T1 
WHERE
    T1.差分 > 0 
ORDER BY
    T1.差分 DESC
    , T1.港コード DESC;

