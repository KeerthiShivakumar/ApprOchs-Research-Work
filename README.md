# In-Memory and Approximate Computing Based Adder Design

## Objective

This project focuses on analyzing, implementing, and extending a research paper in the domain of In-Memory Computing and Approximate Computing. The aim is to study the trade-offs between accuracy, power, area, and speed, while proposing improvements that can contribute towards a publishable research outcome.

## Team

* Keerthi Shivakumar
* Lakshmi Arun

## Guide

* Y J Pavithra

## Work Completed

### Literature Study

* Read and analyzed the selected research paper.
* Studied the concepts of In-Memory Computing and Approximate Computing.
* Presented the paper and discussed key concepts with the guide.
* Understood the ApprOchs architecture and its design methodology.

### Design and Implementation

* Implemented Exact and ApprOchs adders using SystemVerilog and Verilog.
* Simulated and verified functionality using Xilinx Vivado.
* Evaluated the design for multiple values of the approximation parameter *k*.
* Developed an adaptive approximation framework based on user requirements and application constraints.

### Error Analysis

* Generated outputs for all 256 × 256 input combinations.
* Calculated Mean Error Distance (MED) for different values of *k*.
* Verified the obtained MED values against those reported in the reference paper.
* Identified and analyzed corner cases that lead to large approximation errors.

### Hardware Analysis

* Compared Exact and Approximate adders using:
  * Power reports
  * Utilization reports
  * Timing analysis
* Successfully implemented the design on FPGA.
* Performed synthesis and PVT analysis using Cadence Genus.

### Design Exploration

* Investigated majority-gate-based approximation as an alternative to the original OR-based approximation.
* Studied the impact of different approximation strategies on accuracy and hardware metrics.
* Began evaluating approximate adders for image-processing applications such as image blurring.

## Key Observations

* Approximate computing provides significant reductions in power and hardware resource utilization.
* Increasing the approximation level improves efficiency but increases computational error.
* Corner cases contribute disproportionately to overall error metrics.
* Different approximation strategies exhibit different trade-offs between accuracy and efficiency.

## Ongoing Work

* Image blurring implementation and evaluation using approximate adders.
* Comparison of OR-based and majority-based approximation techniques.
* Analysis of image quality metrics such as PSNR and MSE.
* Study of MAGIC and IMPLY logic implementations.

## Project Structure

* `papers/` – Research papers and references
* `notes/` – Literature study and concept summaries
* `ideas/` – Proposed improvements and discussions
* `progress/` – Weekly progress updates
* `code/` – Verilog/SystemVerilog implementations
* `results/` – Simulation, power, timing, and analysis reports

## Current Status

* Literature study completed
* FPGA implementation completed
* MED analysis verified against published results
* Cadence Genus analysis completed
* Image-processing evaluation completed

## Goal

To develop an optimized and adaptable approximate adder architecture and evaluate its effectiveness across hardware and image-processing applications, with the objective of producing a publishable research contribution.
