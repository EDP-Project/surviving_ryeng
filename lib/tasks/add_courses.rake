namespace :db do
  desc "Populate database with course data"
  task add_courses: :environment do

#-- Common Engineering --
  add("CEN100", "Introduction to Engineering", "This course is aimed at familiarizing the first year students with the basic information of the academic structure and expectations. Exposure to public and worker safety and the impact of engineering activities on health as well as safety standards and safety codes will be covered. The course also stresses integration with other first year courses. The principal objectives of the course are to provide a general introduction to the field of engineering; to convey the social, professional, and ethical responsibilities of engineers and why they are important to an engineering education; to introduce the undergraduate engineering programs available at Ryerson University; and to provide a general description of the skills needed to become a practicing engineer. Case studies in engineering are used to illustrate engineering fields and scientific principles.")
  add("CEN199", "Writing Skills", "All engineering students are required to write a mandatory Writing Skills Test (WST) or the diagnostic Ryerson Test of English Proficiency (RTEP), administered during Orientation Week before the beginning of the first semester. Students who pass the WST or RTEP (grade of 'B' or higher) may enroll in their chosen breadth elective (liberal studies) courses. Those students who do not pass the WST and those students who achieve a 'C' level remedial pass on the RTEP, will be required to enroll in LNG 111, LNG 112, LNG 113, or LNG 121 as a breadth elective (lower level liberal studies) course. Students who do not pass the WST or who achieve a 'C' level remedial pass on the RTEP, will have three additional chances to write the WST. The second test will be scheduled in May following the completion of the first year Engineering curriculum. The third and fourth WST will be administered during the next academic year Orientation Week, and again, in May. This course must be successfully completed prior to enrolling in third-year engineering courses. This course is graded on a Pass/Fail basis.")
  add("CEN699", "Research Placement", "Students carry out research projects under the supervision of faculty members in Engineering. Research projects can be theoretical or experimental studies. Students are required to complete written reports. This course is graded on a Pass/Fail basis. Permission by Dean's Office.") 
  add("CEN800", "Law and Ethics in Engineering Practice", "Study of the legal and ethical aspects of engineering practice, including Canadian legal system and business organizations, tort liability, business contract law, intellectual and industrial property, principles of arbitration and alternative dispute resolutions, the practice of engineering, occupational health and safety, ethical aspects of engineering practice, ethical dilemmas in project management, sustainable development and ethical behavior, and globalization and international standards for ethical and social responsibility.")
  add("CPS125", "Digital Computation and Programming", "The C programming language is used to develop good programming techniques. Topics covered include: C program form, language statements, pseudo-code algorithmic representation, numeric data types, flow of control with selection and repetition, standard C libraries, functions and call modes, arrays, pointers, sorting, matrix operations, character and string data types, dynamic storage, structures and linked lists, file I/O. Only regular first year students from the Faculty of Engineering, Architecture, and Science may preregister for this course.")
  add("ECN801", "Principles of Engineering Economics", "Engineering economics is concerned with the problem of investment decision making or capital expenditure analysis. An ?investment? problem involves making a decision to allocate financial resources to acquire productive assets that will generate cash flows in future time periods. Engineering economics seeks to develop and apply a logically consistent methodology for evaluating investment projects. Discounted cash flow methods are used in analyzing such projects. In this course we will assume certain cash flows and ignore taxation implications. After developing the mathematics of cash flow equivalence, absolute and relative measures of project worth will be developed and applied to individual and multiple projects. The emphasis will be on private project decisions, but similar methods will be applied to public sector projects.")
  add("CHY102", "General Chemistry", "This course deals with stoichiometry, gases, liquids and solids, chemical equilibria, thermodynamics, kinetics, nuclear chemistry and electrochemistry. The treatment of these topics will emphasize problem solving and calculation.")
  add("PCS125", "Physics: Waves and Fields", "Simple harmonic motion; motion of mechanical waves, wave speed; sound, Doppler effect, interference, standing waves, beats and resonance; gravitational fields and potential energy; electric fields and potential energy; electric potential; magnetic fields.")
  add("PCS211", "Physics: Mechanics", "Vector forces: forces along a line, coplanar force systems - essentials of vector algebra in two and three dimensions. Moment of a force; moment of a couple; principle of moments. Free body diagrams and equilibrium conditions. Centre of mass and centroids of bodies. Rectilinear and curvilinear motion kinematics. Newton's laws and equations of motion. Friction. Work and Energy; Linear momentum and angular momentum.")
  add("MTH140", "Calculus I", "Limits, continuity, differentiability, rules of differentiation. Absolute and relative extrema, inflection points, asymptotes, curve sketching. Applied max/min problems, related rates. Definite and indefinite integrals, Fundamental Theorem of Integral Calculus. Areas, volumes. Transcendental functions (trigonometric, logarithmic, hyperbolic and their inverses).")
  add("MTH141", "Linear Algebra", "Systems of linear equations and matrices. Determinants. Vector spaces. Inner product spaces. Eigenvalues and eigenvectors.")
  add("MTH 240", "Calculus II", "Integration techniques. L'Hôpital's Rule. Improper integrals. Partial derivatives. Infinite sequences and series, power series. First-order differential equations, with applications.")
  add("", "", "")
  add("", "", "")
  add("", "", "")
  add("", "", "")
  add("", "", "")
  add("", "", "")
  add("", "", "")









#-- Aerospace Engineering
  add("AER222", "Introduction to design: role of design in engineering, problem analysis, conceptual design and analysis, systems thinking, detailed design, design for product life cycle. Technical drawing in compliance with Canadian standards: orthographic and auxiliary views, sections, dimensioning and tolerancing, assembly and working drawings. Sketching and CAD-based methods.")
  add("AER309", "")
  add("AER316", )
  add("AER318", )
  add("AER320", )
  add("AER403", )
  add("AER404", )
  add("AER416", )
  add("AER423", )
  add("AER504", )
  add("AER507", )
  add("AER509", )
  add("AER520", )
  add("AER606", )
  add("AER615", )
  add("AER621", )
  add("AER622", )
  add("AER626", )
  add("AER627", )
  add("AER710", )
  add("AER715", )
  add("AER716", )
  add("AER721", )
  add("AER722", )
  add("AER723", )
  add("AER813", )
  add("AER814", )
  add("AER817", )
  add("AER818", )
  add("AER821", )
  add("AER822", )
  add("AER870", )

#-- Biomedical Engineering
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )
  add(, )


  end
end

def add(code, title, desc)
  Course.create!(course_code: code, title: title, description: desc)
end

