package zl.apirest.backend.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "pymes")
public class Pyme extends PkEntityBase {

    @Column(name = "business_name", nullable = false)
    private String name;

    @Column(name = "business_dni", nullable = false)
    private int dni;

    @Column(name = "phone")
    private int phone;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "email", nullable = false)
    private String email;
    
    @ManyToOne
    @JoinColumn(name = "pymes_address_fk", referencedColumnName = "id", nullable = false)
    private PymeAddress pymeAddress;
    
    @ManyToOne
    @JoinColumn(name = "recycling_type_fk", referencedColumnName = "id", nullable = false)
    private RecyclingType recyclingType;
    
}
