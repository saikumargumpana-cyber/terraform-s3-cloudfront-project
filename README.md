# Terraform AWS S3 + CloudFront Static Website

This project provisions a production-ready static website infrastructure on AWS using Terraform.

It uses:
- Amazon S3 for static website hosting
- Amazon CloudFront for global content delivery
- HTTPS redirection for secure access
- Infrastructure as Code (IaC) using Terraform

---

## 🚀 Architecture

User → CloudFront (CDN) → S3 Bucket (Static Website)

- Website files stored in S3
- CloudFront distributes content globally
- Viewer Protocol Policy: Redirect HTTP to HTTPS
- Fully managed using Terraform

---

## 🛠 Technologies Used

- Terraform
- AWS S3
- AWS CloudFront
- Git & GitHub

---

## 📁 Project Structure
