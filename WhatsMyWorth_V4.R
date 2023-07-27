#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(DBI)
library(RMySQL)
library(ggplot2)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel(h1("WhatsMyWorth: The Ultimate Destination for Your Data Career!",
                style='font-weight: bold; font-size: 42px; padding-left: 15px')),

  # Sidebar with a slider input for number of bins
  tabsetPanel(
    # tab-1
    tabPanel("Salary Insights",
             titlePanel(div(class = "title", "Salary Insights")),
             fluidRow(
               style = "margin-top: 20px; margin-bottom: 20px;",
               column(width = 3,
                      selectInput("companysize", "Select Company Size:",  
                                  choices = c("Small", "Medium", "Large"),  
                                  selected = "Large"),
                      radioButtons("location", "Select Company Location:",  
                                   choices = c("North America" = "True", "Elsewhere" = "False"),  
                                   selected = "True"),
                      radioButtons("emptype", "Select Employment Type:",  
                                   choices = c("Full-Time", "Part-Time", "Contract", "Freelance"),  
                                   selected = "Full-Time"),
                      radioButtons("explevel", "Select Experience Level:",  
                                   choices = c("Entry-level", "Mid-level", "Senior-level","Executive/Director"),  
                                   selected = "Mid-level"),
                      radioButtons("empmode", "Select Employment Mode:",  
                                   choices = c("Onsite", "Hybrid", "Remote"),  
                                   selected = "Onsite"),
                      selectInput("jobfield", "Select Job Field:",  
                                  choices = c("analytics architect", "data analytics", "data engineering",  
                                              "data science", "machine learning", "business intelligence",  
                                              "other"),  
                                  selected = "data science", multiple = FALSE),
               ),
               column(width = 9,  
                      textOutput("jt1"),  
                      textOutput("jt2"),  
                      plotOutput("box1", width = "100%", height = "300px"),  
                      plotOutput("box2", width = "100%", height = "300px"),  
                      plotOutput("scatter1", width = "100%", height = "300px"))
               
             ),
    ),
    
    # tab-2
    tabPanel("Update Data",
             titlePanel(div(class = "title", "Update Data")),
             div(class = "container-fluid",
                 div(class = "custom-layout",
                     div(class = "custom-sidebar",
                         textInput("job_title", "Job Title:"),
                         textInput("salary", "Salary in USD (no commas, no periods):"),
                         textInput("work_year", "What is the year of today's date?"),
                         selectInput("job_field", "Select Job Field:", selected = 'data science',
                                     choices = c('data science', 'data analytics', 'machine learning',
                                                 'data engineering', 'business intelligence',
                                                 'analytics architect', 'other')),
                         selectInput("exp_level", "Select Experience Level:", selected = 'Entry-level',
                                     choices = c("Entry-level", "Mid-level",
                                                 "Senior-level", "Executive/Director")),
                         selectInput("emp_type", "Select Employment Type:", selected = 'Full-time',
                                     choices = c("Contract", "Freelance", "Full-time",
                                                 "Part-time")),
                         selectInput("comp_loc", "Select Company Location:", selected='United States',
                                     choices = c('Afghanistan', 'Albania', 'Algeria', 'Andorra',
                                                 'Angola', 'Antigua and Deps', 'Argentina',
                                                 'Armenia', 'Australia', 'Austria', 'Azerbaijan',
                                                 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados',
                                                 'Belarus', 'Belgium', 'Belize', 'Benin',
                                                 'Bhutan', 'Bolivia', 'Bosnia and Herzegovina', 'Botswana',
                                                 'Brazil', 'Brunei', 'Bulgaria', 'Burkina Faso',
                                                 'Burundi', 'Cambodia', 'Cameroon', 'Canada',
                                                 'Cape Verde', 'Central African Rep', 'Chad', 'Chile',
                                                 'China', 'Colombia', 'Comoros', 'Reputlic of the Congo',
                                                 'Democratic Republic of the Congo', 'Costa Rica', 'Croatia',
                                                 'Cuba', 'Cyprus', 'Czech Republic', 'Denmark', 'Djibouti',
                                                 'Dominica', 'Dominican Republic', 'East Timor', 'Ecuador',
                                                 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea',
                                                 'Estonia', 'Ethiopia', 'Fiji', 'Finland',
                                                 'France', 'Gabon', 'Gambia', 'Georgia',
                                                 'Germany', 'Ghana', 'Great Britain', 'Greece', 'Grenada',
                                                 'Guatemala', 'Guinea', 'Guinea-Bissau', 'Guyana',
                                                 'Haiti', 'Honduras', 'Hungary', 'Iceland',
                                                 'India', 'Indonesia', 'Iran', 'Iraq',
                                                 'Ireland', 'Israel', 'Italy', 'Ivory Coast',
                                                 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan',
                                                 'Kenya', 'Kiribati', 'Korea North', 'Korea South',
                                                 'Kosovo', 'Kuwait', 'Kyrgyzstan', 'Laos',
                                                 'Latvia', 'Lebanon', 'Lesotho', 'Liberia',
                                                 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg',
                                                 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali',
                                                 'Malta', 'Marshall Islands', 'Mauritania', 'Mauritius',
                                                 'Mexico', 'Micronesia', 'Moldova', 'Monaco', 'Mongolia',
                                                 'Montenegro', 'Morocco', 'Mozambique', 'Myanmar',
                                                 'Namibia', 'Nauru', 'Nepal', 'Netherlands',
                                                 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria',
                                                 'North Macedonia', 'Norway', 'Oman', 'Pakistan',
                                                 'Palau', 'Panama', 'Papua New Guinea', 'Paraguay',
                                                 'Peru', 'Philippines', 'Poland', 'Portugal', 'Qatar',
                                                 'Romania', 'Russia', 'Rwanda', 'St Kitts and Nevis',
                                                 'St Lucia', 'Saint Vincent and the Grenadines',
                                                 'American Samoa', 'San Marino', 'Sao Tome and Principe',
                                                 'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles',
                                                 'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia',
                                                 'Solomon Islands', 'Somalia', 'South Africa',
                                                 'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname',
                                                 'Swaziland', 'Sweden', 'Switzerland', 'Syria', 'Taiwan',
                                                 'Tajikistan', 'Tanzania', 'Thailand', 'Togo', 'Tonga',
                                                 'Trinidad and Tobago', 'Tunisia', 'Turkey',
                                                 'Turkmenistan', 'Tuvalu', 'Uganda', 'Ukraine',
                                                 'United Arab Emirates', 'United States',
                                                 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican City',
                                                 'Venezuela', 'Vietnam', 'Yemen', 'Zambia', 'Zimbabwe')),
                         selectInput("comp_loc_na", "Your company is in the US or Canada:",
                                     selected='True', choices = c('True', 'False')),
                         selectInput("comp_size", "Company Size:", selected = 'Medium',
                                     choices = c('Small', 'Medium', 'Large')),
                         selectInput("emp_mode", "Employment Mode:", selected='Onsite',
                                     choices = c('Onsite', 'Hybrid', 'Remote')),
                         br(),
                         actionButton("add_button", "Add Data"),
                         br(),
                         div(
                           verbatimTextOutput("input_summary"),
                           style = "width: 300px; height: 250px;"
                         ),
                       ),
                     div(class = "custom_main",  
                         h3(style = "font-weight: bold", "Data Table"),
                         DT::dataTableOutput("data_table")
                     )
                 )
             )
    ),
             

    # tab-3
    tabPanel("Career Growth",
             tags$head(
               tags$style(HTML("
                                /* Bold font */
                                body {
                                  font-weight: bold;
                                  margin: 0;
                                  padding: 0;
                                }
                                
                                /* Color scheme for sidebar panel */
                                .sidebar .well {
                                  background-color: #D6EAF8;
                                  color: #D6EAF8;
                                }
                                
                                /* Center the title */
                                .title {
                                  text-align: center;
                                  font-size: 40px;
                                  font-weight: bold;
                                }
                                
                                /* Background color for the whole app */
                                .container-fluid {
                                  background-color: #D6EAF8;
                                  padding-right: 20;
                                  padding-left: 20;
                                  margin-right: 20;
                                  margin-left: 20;
                                  margin-top: 20;
                                  margin-bottom: 20;
                                  height: 100%;
                                  width: 100%;
                                }
                                
                                /* Custom Layout */
                                .custom-layout {
                                  display: flex;
                                  justify-content: center;
                                  align-items: flex-start;
                                  height: 100%;
                                }
                                
                                .custom-sidebar {
                                  flex: 0 0 300px;
                                  margin-right: 20px;
                                }
                                
                                .custom-main {
                                  flex: 1;
                                  max-width: 800px;
                                  padding: 20px;
                                  text-align: center;
                                }
                                
                                .custom-graph {
                                  margin-top: 20px;
                                  max-width: 800px;
                                  text-align: center;
                                
                                }
                              ")
                            )
                 ),

                 titlePanel(div(class = "title", "Career Growth")),
                 div(class = "container-fluid",
                     div(class = "custom-layout",
                         div(class = "custom-sidebar",
                         selectInput("job_field3", "Job Field",  
                                     choices = c('data science', 'data analytics', 'machine learning',
                                                 'data engineering', 'business intelligence',
                                                 'analytics architect', 'other')),
                         selectInput("emp_mode3", "Employment Mode",  
                                     choices = c('Onsite', 'Hybrid', 'Remote')),
                         selectInput("emp_type3", "Employment Type", selected='Full-time', 
                                     choices = c("Contract", "Freelance", "Full-time", "Part-time")),
                         selectInput("company_size3", "Company Size",  selected='Large',
                                     choices = c("Small", "Medium", "Large")),
                         selectInput("location3", "Location (True = United States or Canada, False = Otherwise",
                                     choices = c('True', 'False')),
                         br(),
                         actionButton("filter_button", "Whats My Worth!"),
                         br(),
                         actionButton("reset_button", "Reset Filter")
                         ),
                         div(class = "custom_main",
                             div(class = "custom-graph", 
                                 plotOutput("line_plot", width = "100%", height = "400px")
                                 ),
                             h3(style = "font-weight: bold", "Filtered Job Title"),
                             DT::dataTableOutput("job_summary_table"),
                             h3(style = "font-weight: bold;", "Filtered Data"),
                             DT::dataTableOutput("filtered_data_table")
                             )
                     )
                  )
    )
  )
)



# Define server logic required to draw a histogram
server <- function(input, output, session) {
  conn <- dbConnect(MySQL(),
                    host = "127.0.0.1",
                    dbname = "datajobs",
                    user = "root",
                    password = "root")
  data <- dbGetQuery(conn, "SELECT * FROM salaries_preprocessed")
  
  # tab-1: salaries insights
  output$box1 <- renderPlot({
    
    companysize <- paste("company_size =","\"",input$companysize,"\"",sep="")
    location <- paste("AND company_location_na = ","\"",input$location,"\"",sep="")
    emptype <- paste("AND employment_type = ","\"",input$emptype,"\"",sep="")
    explevel <- paste("AND experience_level = ","\"",input$explevel,"\"",sep="")
    empmode <- paste("AND employment_mode = ","\"",input$empmode,"\"",sep="")
    jobfield <- paste("AND job_field = ","\"",input$jobfield,"\"",sep="")
    
    query_string <- paste(companysize,
                          jobfield,
                          empmode,
                          emptype
    )
    
    # print(query_string)
    
    q <-paste("SELECT * FROM salaries_preprocessed WHERE ",query_string)
    df_box1 <- dbGetQuery(conn,q)
    
    # print(tail(df_box1, n=1))
    
    # Create boxplot
    df_box1['salary_in_usd_1k'] <- df_box1$salary_in_usd/1000
    
    job_titles_available <- c(unique(df_box1$job_title))
    output$q <- renderText({
      paste("User Selections:",
            q)
    })
    
    output$jt1 <- renderText({
      paste("Job Titles In Selected Job Field (", input$jobfield, ") are"
      )
    })

    output$jt2 <- renderText({
      paste(paste0(job_titles_available, collapse=", "), sep=" " )
    })
    
    ggplot(df_box1, aes(x =company_location_na , y = salary_in_usd_1k)) +
      labs(x = "Location", y = "Salary ($K USD)")+
      geom_boxplot(fill = "skyblue", color = "red") +
      ggtitle("Salary per Company Location as North America(True) or Elsewhere(False)")

  })
  
  output$box2 <- renderPlot({
    companysize <- paste("company_size =","\"",input$companysize,"\"",sep="")
    location <- paste("company_location_na = ","\"",input$location,"\"",sep="")
    emptype <- paste("AND employment_type = ","\"",input$emptype,"\"",sep="")
    explevel <- paste("AND experience_level = ","\"",input$explevel,"\"",sep="")
    empmode <- paste("AND employment_mode = ","\"",input$empmode,"\"",sep="")
    jobfield <- paste("AND job_field = ","\"",input$jobfield,"\"",sep="")
    
    query_string <- paste(location,
                          jobfield,
                          explevel
    )
    q <-paste("SELECT * FROM salaries_preprocessed WHERE ",query_string)
    df_box2 <- dbGetQuery(conn,q)
    
    # print(tail(df_box2, n=1))
    
    # Create boxplot
    df_box2['salary_in_usd_1k'] <- df_box2$salary_in_usd/1000
    t <- paste("Selections: { Location:",
               input$location,
               "(NA/nonNA), Job Field:",input$jobfield,
               ", Experience:",input$explevel, "}")
    ggplot(df_box2, aes(x = company_size, y = salary_in_usd_1k)) +
      labs(x = "Company Size", y = "Salary ($K USD)")+
      geom_boxplot(fill = "orange", color = "black") +
      ggtitle(t)
    
  })
  
  output$scatter1 <- renderPlot({
    companysize <- paste("company_size =","\"",input$companysize,"\"",sep="")
    location <- paste("AND company_location_na = ","\"",input$location,"\"",sep="")
    emptype <- paste("AND employment_type = ","\"",input$emptype,"\"",sep="")
    explevel <- paste("AND experience_level = ","\"",input$explevel,"\"",sep="")
    empmode <- paste("AND employment_mode = ","\"",input$empmode,"\"",sep="")
    jobfield <- paste("AND job_field = ","\"",input$jobfield,"\"",sep="")
    
    query_string <- paste(companysize,
                          location,
                          emptype
                          
    )
    q <-paste("SELECT * FROM salaries_preprocessed WHERE ",query_string)
    df_scatter1 <- dbGetQuery(conn,q)
    
    # print(tail(df_scatter1, n=1))
    
    # Create boxplot
    df_scatter1['salary_in_usd_1k'] <- df_scatter1$salary_in_usd/1000
    
    # Scatterplot
    t <- paste("Selections: { Company Size:",input$companysize,", Location:",
               input$location,
               "(NA, non-NA), Employment Type:",input$emptype ,"}")
    # print(t)
    ggplot(df_scatter1, aes(x=experience_level, y=salary_in_usd_1k)) + 
      geom_point(aes(col=job_field)) + 
      ylim(c(0, 600)) + 
      labs(
        y="Salary ($K USD)", 
        x="Experience Level", 
        title=t
      )
  })
  
  # tab-2: update data
  # render the initial table
  output$data_table <- renderDataTable({
    datatable(data, options = list(pageLength=25,
                                   search = list(caseInsensitive=TRUE))) 
    })
  
  output$input_summary <- renderText({
    paste("Job Title:", input$job_title, "\n",
          "Salary in USD:", input$salary, "\n",
          "Work Year:", input$work_year, "\n",
          "Job Field:", input$job_field, "\n",
          "Experience Level:", input$exp_level, "\n",
          "Employment Type:", input$emp_type, "\n",
          "Company Location:", input$comp_loc, "\n",
          "Company Location (US/Canada):", input$comp_loc_na, "\n",
          "Company Size:", input$comp_size, "\n",
          "Employment Mode:", input$emp_mode)
  })
  
  observeEvent(input$add_button, {
    tryCatch({
      session <- getDefaultReactiveDomain()
      # Get the maximum value of the primary key column
      max_id <- dbGetQuery(conn, "SELECT MAX(user_id) FROM salaries_preprocessed")$'MAX(user_id)'
      
      # create a new row based on user input
      new_row <- data.frame(user_id = max_id + 1,
                            work_year = input$work_year,
                            experience_level = input$exp_level,
                            employment_type = input$emp_type,
                            job_title = input$job_title,
                            salary_in_usd = input$salary,
                            company_location = input$comp_loc,
                            company_size = input$comp_size,
                            job_field = input$job_field,
                            company_location_na = input$comp_loc_na,
                            employment_mode = input$emp_mode,
                            stringsAsFactors = FALSE)
      
      # append new row to data frame
      data <- rbind(data, new_row)
      
      # insert the new row into the MySQL database
      dbWriteTable(conn, name = "salaries_preprocessed", value = new_row, append = TRUE,
                   field.types = c(user_id = "int", work_year = "int",
                                   experience_level = "varchar(50)",
                                   employment_type = "varchar(50)",
                                   job_title = "varchar(50)", salary_in_usd = "int",
                                   company_location = "varchar(50",
                                   company_size = "varchar(50)",
                                   company_location_na = "varchar(50)",
                                   employment_mode = "varchar(50)"),
                   row.names=FALSE)
      
      # dbWriteTable(conn, name = "salaries_preprocessed", value = new_row, append = TRUE)
      
      # reset input values
      updateTextInput(session, "job_title", value = "")
      updateTextInput(session, "salary", value = "")
      updateTextInput(session, "work_year", value = "")
      updateSelectInput(session, "job_field", selected = NULL)
      updateSelectInput(session, "exp_level", selected = NULL)
      updateSelectInput(session, "emp_type", selected = NULL)
      updateSelectInput(session, "comp_loc", selected = NULL)
      updateSelectInput(session, "comp_loc_na", selected = NULL)
      updateSelectInput(session, "comp_size", selected = NULL)
      updateSelectInput(session, "emp_mode", selected = NULL)
      
      # update data table
      
      output$data_table <- renderDataTable({
        datatable(data, options = list(pageLength=25,
                                       search = list(caseInsensitive=TRUE)))
      })
      
    }, error = function(err) {
      print(err)
    })
    
    on.exit(dbDisconnect(conn))
    
  })
  
  # tab-3: Career Growth
  filtered_data <- reactive({
    # Define the unique values for each filter
    # job_field <- unique(data$job_field)
    # emp_mode <- unique(data$employment_mode)
    # emp_type <- unique(data$employment_type)
    # company_size <- unique(data$company_size)
    # location <- unique(data$company_location_na)
    # experience_level <- unique(data$experience_level)
    
    req(input$job_field3)  # Require Job Field to be selected
    
    data_filtered <- data.frame(data)
    
    if (!is.null(input$job_field3) && input$job_field3 != "") {
      data_filtered <- data_filtered %>%
        filter(job_field %in% input$job_field3)
    }
    if (!is.null(input$emp_mode3) && input$emp_mode3 != "") {
      data_filtered <- data_filtered %>%
        filter(employment_mode %in% input$emp_mode3)
    }
    if (!is.null(input$emp_type3) && input$emp_type3 != "") {
      data_filtered <- data_filtered %>%
        filter(employment_type %in% input$emp_type3)
    }
    if (!is.null(input$company_size3) && input$company_size3 != "") {
      data_filtered <- data_filtered %>%
        filter(company_size %in% input$company_size3)
    }
    if (!is.null(input$location3) && input$location3 != "") {
      data_filtered <- data_filtered %>%
        filter(company_location_na %in% input$location3)
    }
    
    data_filtered
  })
  
  filtered_job_table <- reactive({
    filtered <- data.frame(filtered_data())
    
    job_table <- filtered %>%
      group_by(job_title) %>%
      summarize(count = n(), median_salary = median(salary_in_usd))
    
    job_table
  })
  
  output$job_summary_table <- DT::renderDataTable({
    job_table <- filtered_job_table()
    DT::datatable(job_table, options = list(pageLength = 25))
  })
  
  output$filtered_data_table <- DT::renderDataTable({
    data.frame(filtered_data())
  })
  
  # Line Graph 
  observeEvent(input$filter_button, {

    filtered <- data.frame(filtered_data())
    
    median_salary <- filtered %>%
      group_by(experience_level) %>%
      summarize(median_salary = median(salary_in_usd)/1000)
    
    output$line_plot <- renderPlot({
      ggplot(median_salary, aes(x = factor(experience_level,  
                                           level = c("Entry-level", "Mid-level", "Senior-level", "Executive/Director")),  
                                y = median_salary, group = 1)) +  
        geom_line() +
        geom_point(size = 3) +
        geom_text(aes(label= median_salary), hjust = -0.2, vjust = 0.5)+  
        labs(x = "Experience Level", y = "Salary In USD ($K)")
    })
  })
  
  observeEvent(input$reset_button, {
    updateSelectInput(session, "job_field", selected = NULL)
    updateSelectInput(session, "emp_mod", selected = NULL)
    updateSelectInput(session, "emp_type", selected = NULL)
    updateSelectInput(session, "company_size", selected = NULL)
    updateSelectInput(session, "location", selected = NULL)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
