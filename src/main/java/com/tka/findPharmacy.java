package com.tka;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/findPharmacy")
public class findPharmacy extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String userLatitude =
                req.getParameter("user_latitude");

        String userLongitude =
                req.getParameter("user_longitude");

        if (userLatitude == null ||
            userLongitude == null ||
            userLatitude.isEmpty() ||
            userLongitude.isEmpty()) {

            resp.sendRedirect(
                    "findPharmacy.jsp"
            );

            return;
        }

        try {

            double latitude =
                    Double.parseDouble(userLatitude);

            double longitude =
                    Double.parseDouble(userLongitude);

            Class.forName(
                    "com.mysql.cj.jdbc.Driver"
            );

            Connection c =
                    DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/medicinefinder",
                            "root",
                            "Password"
                    );

            PreparedStatement ps =
                    c.prepareStatement(
                            "SELECT pharmacy_id, owner_name, " +
                            "pharmacy_name, email, mobile, " +
                            "address, city, pincode, " +
                            "latitude, longitude " +
                            "FROM pharmacy"
                    );

            ResultSet rs =
                    ps.executeQuery();

            List<Pharmacy> pharmacyList =
                    new ArrayList<>();


            while (rs.next()) {

                Pharmacy pharmacy =
                        new Pharmacy();


                pharmacy.setPharmacyId(
                        rs.getInt("pharmacy_id")
                );


                pharmacy.setOwnerName(
                        rs.getString("owner_name")
                );


                pharmacy.setPharmacyName(
                        rs.getString("pharmacy_name")
                );


                pharmacy.setEmail(
                        rs.getString("email")
                );


                pharmacy.setMobile(
                        rs.getString("mobile")
                );


                pharmacy.setAddress(
                        rs.getString("address")
                );


                pharmacy.setCity(
                        rs.getString("city")
                );


                pharmacy.setPincode(
                        rs.getString("pincode")
                );


                double pharmacyLatitude =
                        rs.getDouble("latitude");

                boolean latitudeNull =
                        rs.wasNull();


                double pharmacyLongitude =
                        rs.getDouble("longitude");

                boolean longitudeNull =
                        rs.wasNull();


                if (!latitudeNull &&
                    !longitudeNull) {

                    pharmacy.setLatitude(
                            pharmacyLatitude
                    );

                    pharmacy.setLongitude(
                            pharmacyLongitude
                    );


                    double distance =
                            calculateDistance(
                                    latitude,
                                    longitude,
                                    pharmacyLatitude,
                                    pharmacyLongitude
                            );


                    pharmacy.setDistance(
                            distance
                    );

                    pharmacy.setLocationAvailable(
                            true
                    );

                } else {

                    pharmacy.setDistance(
                            Double.MAX_VALUE
                    );

                    pharmacy.setLocationAvailable(
                            false
                    );
                }


                pharmacyList.add(
                        pharmacy
                );
            }


            pharmacyList.sort(
                    Comparator.comparingDouble(
                            Pharmacy::getDistance
                    )
            );


            req.setAttribute(
                    "pharmacyList",
                    pharmacyList
            );


            rs.close();
            ps.close();
            c.close();


            req.getRequestDispatcher(
                    "pharmacyResults.jsp"
            ).forward(req, resp);


        } catch (Exception e) {

            e.printStackTrace();

            resp.sendRedirect(
                    "findPharmacy.jsp"
            );
        }
    }


    private double calculateDistance(
            double userLatitude,
            double userLongitude,
            double pharmacyLatitude,
            double pharmacyLongitude) {

        final double EARTH_RADIUS = 6371;


        double latDifference =
                Math.toRadians(
                        pharmacyLatitude -
                        userLatitude
                );


        double longitudeDifference =
                Math.toRadians(
                        pharmacyLongitude -
                        userLongitude
                );


        double a =
                Math.sin(latDifference / 2)
                *
                Math.sin(latDifference / 2)
                +
                Math.cos(
                        Math.toRadians(
                                userLatitude
                        )
                )
                *
                Math.cos(
                        Math.toRadians(
                                pharmacyLatitude
                        )
                )
                *
                Math.sin(
                        longitudeDifference / 2
                )
                *
                Math.sin(
                        longitudeDifference / 2
                );


        double c =
                2 *
                Math.atan2(
                        Math.sqrt(a),
                        Math.sqrt(1 - a)
                );


        return EARTH_RADIUS * c;
    }


    public static class Pharmacy {

        private int pharmacyId;

        private String ownerName;

        private String pharmacyName;

        private String email;

        private String mobile;

        private String address;

        private String city;

        private String pincode;

        private double latitude;

        private double longitude;

        private double distance;

        private boolean locationAvailable;


        public int getPharmacyId() {
            return pharmacyId;
        }


        public void setPharmacyId(
                int pharmacyId) {

            this.pharmacyId =
                    pharmacyId;
        }


        public String getOwnerName() {
            return ownerName;
        }


        public void setOwnerName(
                String ownerName) {

            this.ownerName =
                    ownerName;
        }


        public String getPharmacyName() {
            return pharmacyName;
        }


        public void setPharmacyName(
                String pharmacyName) {

            this.pharmacyName =
                    pharmacyName;
        }


        public String getEmail() {
            return email;
        }


        public void setEmail(
                String email) {

            this.email =
                    email;
        }


        public String getMobile() {
            return mobile;
        }


        public void setMobile(
                String mobile) {

            this.mobile =
                    mobile;
        }


        public String getAddress() {
            return address;
        }


        public void setAddress(
                String address) {

            this.address =
                    address;
        }


        public String getCity() {
            return city;
        }


        public void setCity(
                String city) {

            this.city =
                    city;
        }


        public String getPincode() {
            return pincode;
        }


        public void setPincode(
                String pincode) {

            this.pincode =
                    pincode;
        }


        public double getLatitude() {
            return latitude;
        }


        public void setLatitude(
                double latitude) {

            this.latitude =
                    latitude;
        }


        public double getLongitude() {
            return longitude;
        }


        public void setLongitude(
                double longitude) {

            this.longitude =
                    longitude;
        }


        public double getDistance() {
            return distance;
        }


        public void setDistance(
                double distance) {

            this.distance =
                    distance;
        }


        public boolean isLocationAvailable() {
            return locationAvailable;
        }


        public void setLocationAvailable(
                boolean locationAvailable) {

            this.locationAvailable =
                    locationAvailable;
        }
    }
}