SELECT *
from Portfolio_Project.dbo.NashvilleHousing

SELECT SaleDateconverted, CONVERT(Date, SaleDate)
from Portfolio_Project.dbo.NashvilleHousing

UPDATE Portfolio_Project.dbo.NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE Portfolio_Project.dbo.NashvilleHousing
Add SaleDateconverted Date;

Update  Portfolio_Project.dbo.NashvilleHousing
SET SaleDateconverted = CONVERT(Date, SaleDate)


SELECT *
from Portfolio_Project.dbo.NashvilleHousing
--where PropertyAddress is null
order by ParcelID;


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from Portfolio_Project.dbo.NashvilleHousing a
JOIN Portfolio_Project.dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
AND a.[UniqueID] <> b.[UniqueID]
where a.PropertyAddress is null;


update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from Portfolio_Project.dbo.NashvilleHousing a
JOIN Portfolio_Project.dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
AND a.[UniqueID] <> b.[UniqueID]
where a.PropertyAddress is null;

SELECT PropertyAddress
from Portfolio_Project.dbo.NashvilleHousing
--where PropertyAddress is null
--order by ParcelID;

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
,SUBSTRING(PropertyAddress,  CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address

from Portfolio_Project.dbo.NashvilleHousing

ALTER TABLE Portfolio_Project.dbo.NashvilleHousing
Add PropertySplitAddress varchar(255);

Update  Portfolio_Project.dbo.NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE Portfolio_Project.dbo.NashvilleHousing
Add PropertySplitCity varchar(255);

Update  Portfolio_Project.dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress,  CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) 


SELECT *
from Portfolio_Project.dbo.NashvilleHousing


SELECT OwnerAddress
from Portfolio_Project.dbo.NashvilleHousing

SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
from Portfolio_Project.dbo.NashvilleHousing

ALTER TABLE Portfolio_Project.dbo.NashvilleHousing
Add OwnerSplitAddress varchar(255);

Update  Portfolio_Project.dbo.NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE Portfolio_Project.dbo.NashvilleHousing
Add OwnerSplitCity varchar(255);

Update  Portfolio_Project.dbo.NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE Portfolio_Project.dbo.NashvilleHousing
Add OwnerSplitState varchar(255);

Update  Portfolio_Project.dbo.NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

SELECT *
from Portfolio_Project.dbo.NashvilleHousing

SELECT DISTINCT(SoldAsVacant),COUNT(SoldAsVacant)
from Portfolio_Project.dbo.NashvilleHousing
Group by SoldAsVacant
Order by 2

SELECT SoldAsVacant
,CASE when SoldAsVacant ='Y' then 'Yes'
      when SoldAsVacant = 'N' then 'No'
	  ELSE SoldAsVacant
	  END
from Portfolio_Project.dbo.NashvilleHousing

UPDATE Portfolio_Project.dbo.NashvilleHousing
SET SoldAsVacant = CASE when SoldAsVacant ='Y' then 'Yes'
      when SoldAsVacant = 'N' then 'No'
	  ELSE SoldAsVacant
	  END

WITH RowNumCTE AS(
select *,
    ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
                 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
				    UniqueID
					) row_num

from Portfolio_Project.dbo.NashvilleHousing
--order by ParcelID
)
select *
from RowNumCTE
where row_num > 1
order by PropertyAddress

select *
from Portfolio_Project.dbo.NashvilleHousing

ALTER TABLE Portfolio_Project.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE Portfolio_Project.dbo.NashvilleHousing
DROP COLUMN SaleDate
