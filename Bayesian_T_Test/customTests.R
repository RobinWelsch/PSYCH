# Bayesian T-Test

script_results_identical <- function(result_name) {
  e <- get('e', parent.frame())

  # --- Evaluate student's script ---
  student_script_path <- e$script_temp_path
  # Create a new environment for the student's script, inheriting from globalenv
  # so it can access data like 'darkmode' if needed.
  student_env <- new.env(parent = globalenv())
  student_script_error <- FALSE

  # Capture console output during sourcing to keep things clean
  capture.output(
    tryCatch({
      # Source student's script in its own environment
      source(student_script_path, local = student_env, chdir = TRUE, encoding = "UTF-8")
    }, error = function(cond) {
      student_script_error <<- TRUE
    })
  )

  # 1. Check if student's script had a sourcing error
  if (student_script_error) {
    return(FALSE)
  }

  # 2. Check if the student's script produced the expected result object in its environment
  if (!exists(result_name, envir = student_env)) {
    return(FALSE)
  }
  user_res <- get(result_name, envir = student_env)

  # --- Evaluate correct script ---
  # Ensure e$correct_script_temp_path is valid (Swirl should provide this)
  if (is.null(e$correct_script_temp_path) || !file.exists(e$correct_script_temp_path)) {
    return(FALSE)
  }
  correct_script_path <- e$correct_script_temp_path

  # Create a new environment for the correct script
  tempenv_correct <- new.env(parent = globalenv())
  correct_script_had_error <- FALSE

  capture.output(
    tryCatch({
      source(correct_script_path, local = tempenv_correct, chdir = TRUE, encoding = "UTF-8")
    }, error = function(cond) {
      correct_script_had_error <<- TRUE
    })
  )

  # 3. Check if the correct script ran successfully and produced the result object
  if (correct_script_had_error || !exists(result_name, envir = tempenv_correct)) {
    return(FALSE)
  }
  correct_res <- get(result_name, envir = tempenv_correct)

  # 4. Compare the student's result (from student_env) with the correct result
  are_identical <- identical(user_res, correct_res)
  return(are_identical)
}
