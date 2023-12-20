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
@Table(name = "communes")
public class Commune extends PkEntityBase {

    @Column(name = "commune_name", nullable = false)
    private String name;

    @ManyToOne
    @JoinColumn(name = "province_fk", referencedColumnName = "id", nullable = false)
    private Province province;

}
