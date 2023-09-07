
Select *
From PotfolioProjectSql..Housing_Estate1


Select SaleDate, CONVERT(Date, SaleDate)
From PotfolioProjectSql..Housing_Estate1

UPDATE Housing_Estate1
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE Housing_Estate1
ADD SaleDateConverted2 Date;

UPDATE Housing_Estate1
SET SaleDateConverted2 = CONVERT(Date, SaleDate)


Select SaleDateConverted2, CONVERT(Date, SaleDate)
From PotfolioProjectSql..Housing_Estate1

Select *
From PotfolioProjectSql..Housing_Estate1
--Where PropertyAddress IS Null
Order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PotfolioProjectSql..Housing_Estate1 a
JOIN PotfolioProjectSql..Housing_Estate1 b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress Is Null
 
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PotfolioProjectSql..Housing_Estate1 a
JOIN PotfolioProjectSql..Housing_Estate1 b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress Is Null
	


Select PropertyAddress
From PotfolioProjectSql..Housing_Estate1

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 ,LEN(PropertyAddress)) as Address
From PotfolioProjectSql..Housing_Estate1



ALTER TABLE Housing_Estate1
ADD PropertySplitAddress Nvarchar(255);

UPDATE Housing_Estate1
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 


ALTER TABLE Housing_Estate1
ADD PropertySplitCity Nvarchar(255);

UPDATE Housing_Estate1
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 ,LEN(PropertyAddress)) 

Select *
From PotfolioProjectSql..Housing_Estate1




Select OwnerAddress
From PotfolioProjectSql..Housing_Estate1

Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From PotfolioProjectSql..Housing_Estate1



ALTER TABLE Housing_Estate1
ADD OwnerSplitAddress1 Nvarchar(255);

UPDATE Housing_Estate1
SET OwnerSplitAddress1 = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE Housing_Estate1
ADD OwnerSplitCity Nvarchar(255);

UPDATE Housing_Estate1
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE Housing_Estate1
ADD OwnerSplitState Nvarchar(255);

UPDATE Housing_Estate1
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


Select *
From PotfolioProjectSql..Housing_Estate1

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PotfolioProjectSql..Housing_Estate1
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
, CASE	When SoldAsVacant = 'Y' Then 'Yes' 
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
		End
From PotfolioProjectSql..Housing_Estate1
 
 UPDATE Housing_Estate1
 SET SoldAsVacant = CASE	When SoldAsVacant = 'Y' Then 'Yes' 
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
		End

WITH RowNumCTE As (
SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PotfolioProjectSql..Housing_Estate1
--Order by ParcelID
)
SELECT *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

SELECT *
From PotfolioProjectSql..Housing_Estate1


ALTER TABLE PotfolioProjectSql..Housing_Estate1
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PotfolioProjectSql..Housing_Estate1
DROP COLUMN SaleDate