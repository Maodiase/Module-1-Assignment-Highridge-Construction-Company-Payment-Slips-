
male_first_names <- c(
  "James", "John", "Robert", "Michael", "William", "David", "Richard",
  "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew",
  "Anthony", "Mark", "Donald", "Steven", "Paul", "Andrew", "Joshua",
  "Kevin", "Brian", "Ge?rge", "Timothy", "Ronald", "Edward", "Jason",
  "Jeffrey", "Ryan", "Jacob", "Gary", "Nicholas", "Eric", "Jonathan",
  "Stephen", "Larry", "Justin", "Scott", "Brandon", "Frank"
)

female_first_names <- c(
  "Mary", "Patricia", "Jennifer", "Linda", "Barbara"? "Elizabeth",
  "Susan", "Jessica", "Sarah", "Karen", "Lisa", "Nancy", "Betty",
  "Margaret", "Sandra", "Ashley", "Dorothy", "Kimberly", "Emily",
  "Donna", "Michelle", "Carol", "Amanda", "Melissa", "Deborah",
  "Stephanie", "Rebecca", "Sharon", "Laura", "?ynthia", "Kathleen",
  "Amy", "Angela", "Shirley", "Anna", "Brenda", "Pamela", "Emma",
  "Nicole", "Helen", "Diane"
)

last_names <- c(
  "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller",
  "Davis", "Rodriguez", "Martinez", "Hernandez",?"Lopez", "Gonzalez",
  "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin",
  "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark",
  "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King",
  "Wright", "Scott", "?orres", "Nguyen", "Hill", "Flores", "Green",
  "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell",
  "Carter", "Roberts"
)

generate_workers <- function(count = 400) {
  ids     <- sprintf("EMP%04d", seq_len(count))
  genders <- sample(c(?Male", "Female"), count, replace = TRUE)
  
  first_names <- ifelse(
    genders == "Male",
    sample(male_first_names,   count, replace = TRUE),
    sample(female_first_names, count, replace = TRUE)
  )
  surnames <- sample(last_names, count, replace = T?UE)
  names    <- paste(first_names, surnames)
  salaries <- round(runif(count, min = 5000, max = 35000), 2)
  
  data.frame(
    id     = ids,
    name   = names,
    gender = genders,
    salary = salaries,
    stringsAsFactors = FALSE
  )
}
get_employee?level <- function(salary, gender) {
  level <- "Standard"
}
  
  if (salary > 10000 && salary < 20000) {       
    level <- "A1"
  }
  if (salary > 7500 && salary < 30000 {        
    level <- "A5-F"                               
  }
  
  return(level)
?

print_payment_slip <- function(worker) {
  level <- get_employee_level(worker$salary, worker$gender)
  cat(strrep("=", 40), "\n")
  cat(formatC("PAYMENT SLIP", width = 40, flag = "-"), "\n")
  cat(strrep("=", 40), "\n")
  cat(sprintf("  Employee ID    : ?s\n",        worker$id))
  cat(sprintf("  Name           : %s\n",        worker$name))
  cat(sprintf("  Gender         : %s\n",        worker$gender))
  cat(sprintf("  Salary         : $%s\n",
              format(worker$salary, big.mark = ",", nsmall = 2)?)
  cat(sprintf("  Employee Level : %s\n",        level))
  cat(strrep("=", 40), "\n\n")
}

tryCatch({
  
  workers <- generate_workers(400)
  
  if (nrow(workers) == 0) {
    stop("Worker list is empty - no slips to generate.")
  }
  
  cat(sprintf("Gener?ting payment slips for %d workers...\n\n", nrow(workers)))
  
  level_counts <- list(A1 = 0, "A5-F" = 0, Standard = 0)
  
  for (i in seq_len(nrow(workers))) {
    tryCatch({
      worker <- workers[i, ]
      print_payment_slip(worker)
      level <- get_?mployee_level(worker$salary, worker$gender)
      level_counts[[level]] <- level_counts[[level]] + 1
      
    }, error = function(e) {
      cat(sprintf("[ERROR] Worker %s: %s. Skipping.\n",
                  workers$id[i], conditionMessage(e)))
    })
 ?}
  cat(strrep("=", 40), "\n")
  cat(formatC("SUMMARY", width = 40, flag = "-"), "\n")
  cat(strrep("=", 40), "\n")
  cat(sprintf("  Total workers processed      : %d\n", nrow(workers)))
  cat(sprintf("  Level A1  (10k-20k)         : %d\n", level_counts[["?1"]]))
  cat(sprintf("  Level A5-F (female 7.5k-30k): %d\n", level_counts[["A5-F"]]))
  cat(sprintf("  Level Standard               : %d\n", level_counts[["Standard"]]))
  cat(strrep("=", 40), "\n")
  
}, error = function(e) {
  cat(sprintf("[CRITICAL] %s\?", conditionMessage(e)))
})

