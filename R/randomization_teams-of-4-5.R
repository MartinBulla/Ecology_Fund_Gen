# constants
x = 4 # number of students in smaller groups
y = 5 # number of students in larger groups
k = 10 # topics

# load data (check which students are truly present)
students <- read.delim("./Data/dat_students_attendance.txt")
setnames(students, 'V1', 'First')

# trim student if any

# (Optional) add new students if any here
#new_students <- c( "First Last", "Second Last"); students = rbind(students, new_students)

# create an ordered vector
names_vec <- as.character(students$Name)
names_vec <- names_vec[order(names_vec)]
names_vec

n <- length(names_vec)
stopifnot(n >= x*k && n <= y*k)  # ensures all groups can be size x-y

# Randomly choose which groups get the extra people (e.g. 5 groups of 5, 5 groups of 4 when n=45)
base_size <- floor(n / k)        # e.g. 4 for n=45
sizes <- rep(base_size, k)
extra <- n - sum(sizes)          # number of groups that will have +1 member
if (extra > 0) {
  bump <- sample.int(k, extra)   # different on each run
  sizes[bump] <- sizes[bump] + 1
}

# Shuffle and split without replacement (different each run)
shuffled <- sample(names_vec, n, replace = FALSE)
groups <- split(shuffled, rep(seq_len(k), times = sizes))

# Optional: tidy data.frame
group_df <- data.frame(
  Group = paste0("Group_", rep(seq_len(k), times = sizes)),
  Name  = unlist(groups, use.names = FALSE),
  row.names = NULL
)

# Quick printout
for (i in seq_along(groups)) {
  cat(sprintf("Group %d (%d): %s\n", i, length(groups[[i]]), paste(groups[[i]], collapse = ", ")))
}
