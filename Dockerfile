# Base image for Pandoc and LaTeX functionalities
FROM pandoc/latex:3.8.3-alpine

# --- Japanese Language Support ---
# Update tlmgr and install Japanese language collection (ipaex is a common font)
RUN tlmgr update --self && \
    tlmgr install collection-langjapanese ipaex

# --- Dependencies and Downloads (PlantUML / Custom Template) ---
# Install Java (for PlantUML execution) and Node.js/npm (for filter)
RUN apk update && \
    apk add --no-cache openjdk17-jdk nodejs npm

# Install PlantUML Pandoc filter globally
RUN npm install -g pandoc-plantuml-filter

# --- Entrypoint Script Configuration ---
WORKDIR /data

# Copy the core conversion script (requires LF line endings)
COPY pandoc-convert.sh /usr/local/bin/
COPY template/toc-sidebar.html /usr/local/share/pandoc/templates/
RUN chmod +x /usr/local/bin/pandoc-convert.sh

# Set the entrypoint to the core conversion script
ENTRYPOINT ["/usr/local/bin/pandoc-convert.sh"]