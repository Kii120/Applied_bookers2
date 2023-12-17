# Use an official Ruby runtime as a parent image
FROM ruby:2.6.3

# Set the working directory in the container
WORKDIR /app

# Copy Gemfile and Gemfile.lock from the project root into the container
COPY Gemfile Gemfile.lock ./

# Install any needed packages specified in the Gemfile
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Command to run on container start
CMD ["rails", "server", "-b", "0.0.0.0"]
