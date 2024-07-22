library("readxl")
library("data.table")
library("writexl")

# Import nums1 and nums2
setwd("/Users/navid/Documents/Pyhton/R")

nums1 <- read_excel("nums1.xlsx")
nums2 <- read_excel("nums2.xlsx")

# Adjust nums2 columns as specified
nums2[, 3] <- nums2[, 2]
nums2[, 2] <- NA

# Convert nums1 and nums2 to matrices (ensuring they have the correct dimensions)
nums1 <- as.matrix(nums1)
nums2 <- as.matrix(nums2)

# Get the number of rows in nums1 and nums2
m <- nrow(nums1)
n <- nrow(nums2)

# Initialize mydata matrix with NA values
mydata <- matrix(NA, nrow = m + n, ncol = 3)

# Initialize pointers
p1 <- m
p2 <- n
wp <- m + n

# Iterate and compare elements in nums1 and nums2
while (wp > 0) {
  if (p1 > 0 & (p2 <= 0 | nums1[p1, 1] > nums2[p2, 1])) {
    mydata[wp, 1] <- nums1[p1, 1]
    mydata[wp, 2] <- nums1[p1, 2]
    #mydata[wp, 3] <- nums1[p1, 3]
    p1 <- p1 - 1
  } else {
    mydata[wp, 1] <- nums2[p2, 1]
    mydata[wp, 2] <- nums2[p2, 2]
    mydata[wp, 3] <- nums2[p2, 3]
    p2 <- p2 - 1
  }
  wp <- wp - 1
}

# If there are remaining elements in nums1
while (p1 > 0) {
  mydata[wp, 1] <- nums1[p1, 1]
  mydata[wp, 2] <- nums1[p1, 2]
  #mydata[wp, 3] <- nums1[p1, 3]
  p1 <- p1 - 1
  wp <- wp - 1
  print ("yes")
}

# If there are remaining elements in nums2
while (p2 > 0) {
  mydata[wp, 1] <- nums2[p2, 1]
  mydata[wp, 2] <- nums2[p2, 2]
  mydata[wp, 3] <- nums2[p2, 3]
  p2 <- p2 - 1
  wp <- wp - 1
  print ("no")
}

# Print the merged data
print(mydata)

mydata_df <- as.data.frame(mydata)

write_xlsx(mydata_df,"/Users/navid/Documents/Pyhton/R/data.xlsx")

